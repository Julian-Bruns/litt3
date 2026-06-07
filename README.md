the files are not intended to be read by humans, instead they served as a place where codex could write down what it proved. 
the workflow i used is the following: i gave Codex access to this folder and to the browser, and used /goal to tell it to resolver the problem.
the model continued until it hit a difficult problem, at which point it used the browser to access 5.5 Pro (Extended) and gave it a prompt to solve that isolated problem.
this keeps the context of the solver (5.5 Pro) clean and only contains the relevant context put in the prompt. 
for the prompt, i used something similar to what OpenAI used for the unit distance problem, as it let the model work longer and deviate from the goal less: context description, call to solve it completely, forbid internet access and some steering if the model had repeatedly gone wrong before, a description of two acceptable outcomes.
my pro subscription is used up now, but perhaps someone else can take this further. 
