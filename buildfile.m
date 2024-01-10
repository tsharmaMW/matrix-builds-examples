function plan = buildfile
import matlab.buildtool.tasks.TestTask;

% Create a plan from task functions
plan = buildplan(localfunctions);

% Add a task to run tests and generate test and coverage results
plan("testMex") = TestTask(TestResults="test-results/results.xml");
plan("testMex").Dependencies = ["createMex"];

end

function createMexTask(~)
    % Create a MEX file
    mex code/arrayProduct.c -outdir toolbox/;
end

function packageToolboxTask(~)
    % Create an mltbx toolbox package
    dir toolbox/*.mex*;
    identifier = "arrayProduct";
    toolboxFolder = "toolbox";
    opts = matlab.addons.toolbox.ToolboxOptions(toolboxFolder,identifier);
    
    opts.ToolboxName = "Cross Platform - Array Product Toolbox";
    opts.MinimumMatlabRelease = "R2023b";

    matlab.addons.toolbox.packageToolbox(opts);
end