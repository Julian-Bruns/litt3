// Read-only integrity check for retained checkpoints before removing old snapshots.
// Uses the two checksum formats already implemented by the local solver sources.
#include <array>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>

int main(int argc, char** argv) {
    try {
        if (argc != 2) throw std::runtime_error("usage: check_cleanup_checkpoint PATH");
        std::ifstream in(argv[1], std::ios::binary);
        if (!in) throw std::runtime_error("open failed");
        in.seekg(0, std::ios::end);
        const auto size = static_cast<std::uint64_t>(in.tellg());
        if (size < 64) throw std::runtime_error("short checkpoint");
        in.seekg(0);
        std::uint64_t magic;
        in.read(reinterpret_cast<char*>(&magic), 8);
        const bool f4 = magic == 0x41544c4153463443ULL;
        if (!f4 && magic != 0x4d414341554c3031ULL && magic != 0x4d414341554c3032ULL)
            throw std::runtime_error("unknown checkpoint format");
        auto hash = f4 ? 14695981039346656037ULL : 1469598103934665603ULL;
        in.seekg(0);
        std::array<unsigned char, 1024 * 1024> buffer;
        auto remaining = size - 8;
        while (remaining) {
            auto count = remaining < buffer.size() ? remaining : buffer.size();
            if (!in.read(reinterpret_cast<char*>(buffer.data()), count))
                throw std::runtime_error("truncated checkpoint");
            for (std::uint64_t i = 0; i < count; ++i) {
                hash ^= buffer[i];
                hash *= 1099511628211ULL;
            }
            remaining -= count;
        }
        std::uint64_t saved;
        if (!in.read(reinterpret_cast<char*>(&saved), 8) || saved != hash)
            throw std::runtime_error("checkpoint checksum mismatch");
        std::cout << "{\"status\":\"PASS\",\"bytes\":" << size
                  << ",\"format\":\"" << (f4 ? "F4" : "Macaulay") << "\"}\n";
    } catch (const std::exception& error) {
        std::cerr << error.what() << "\n";
        return 1;
    }
}
