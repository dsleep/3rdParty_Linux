#!/usr/bin/env python

import subprocess
from zipfile import ZipFile
import sys
import os
import json
import glob
import multiprocessing
import platform

def GetJSONName():
    SystemName = platform.system()
    MachineType = platform.machine()    
    
    if SystemName == 'Windows':
        return 'ModulesToBuild_Win.json'
    elif SystemName == 'Linux':    
        return 'ModulesToBuild_Linux.json'
    else:
        return 'unknown'

def get_script_path():
    return os.path.dirname(os.path.realpath(__file__))
    
def which(program):

    def is_exe(fpath):
        return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

    fpath, fname = os.path.split(program)
    if fpath:
        if is_exe(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            exe_file = os.path.join(path, program)
            if is_exe(exe_file):
                return exe_file

    return None
    
def RunAndWait(ProgramLaunch, LogName=''):
    print("Running {}...".format(ProgramLaunch))
    
    LogFile = None
    
    if LogName != '':
        LogFile = open(LogName + ".log.txt","w")
    
    process = subprocess.Popen(ProgramLaunch, bufsize=2048, shell=True, stdout=subprocess.PIPE, encoding='utf8', close_fds=True)
    while True:
        output = process.stdout.readline()
        if output == '' and process.poll() is not None:
            break
        if output:
            print(output) #, end = '')
            if LogFile:
                LogFile.write(output)
    rc = process.poll()
    
    if LogFile:
        LogFile.close()
        
    #print("ERROR CODE" + process.returncode) //// hmmm
    
    return "DONE"                   

ThirdPartyPath = os.path.abspath( "./") + "/INSTALL"
ThirdPartyForwardPath = ThirdPartyPath.replace( "\\", "/" )
ScriptPath = get_script_path()
CMakeLibInstall = "lib"
OSCPUCount = str(multiprocessing.cpu_count())

SystemName = platform.system()
FileName = GetJSONName()

print("ThirdPartyPath: " + ThirdPartyPath)
print("CPU Count: " + OSCPUCount)
print("FileName: " + FileName)

with open(FileName) as json_file:
    data = json.load(json_file)
    
    cmakeString = data['CMakePlatform']
    
    for p in data['modules']:
        print('ModuleName: ' + p['ModuleName'])
                
        if "Command" in p:
            print('Command Args')
            
            LocalArgs = p['Command']            
            print("Command CALL: " + ExecutionString)
            RunAndWait(ExecutionString, "../" + p['ModuleName'] + "_CMAKE" )
             
        if "CMakeArgs" in p:
        
            print('Cmake Args')
            
            print(os.getcwd())
            os.chdir(p['LocalPath'])
            print(os.getcwd())
            
            OutputPath = ThirdPartyPath + "/" + p['LocalPath']
            CMakeLocalLibInstall = OutputPath + "\\" + CMakeLibInstall
            
            LocalCMakeArgs = cmakeString + p['CMakeArgs'] + " -DThirdPartyPath:PATH=\"" + ThirdPartyPath + "\" -C \"" + ScriptPath + "/CMakeCachePreload.cmake\" "
            LocalCMakeArgs = LocalCMakeArgs.replace( "$CMakeVSString", CMakeVSString )
            LocalCMakeArgs = LocalCMakeArgs.replace( "$GitRootDirectory", GitRootDirectory )
            LocalCMakeArgs = LocalCMakeArgs.replace( "$VSMakeBuildFolder", VSMakeBuildFolder
            LocalCMakeArgs = LocalCMakeArgs.replace( "$OutputPath", OutputPath )
            LocalCMakeArgs = LocalCMakeArgs.replace( "$CMakeLibInstall", CMakeLibInstall )
            LocalCMakeArgs = LocalCMakeArgs.replace( "\\", "/" )
            LocalCMakeArgs = LocalCMakeArgs.replace( "$3rdPartyForwardPath", ThirdPartyForwardPath )
            LocalCMakeArgs = LocalCMakeArgs.replace( "$CMakeLocalLibInstall", CMakeLocalLibInstall )                                
                        
            ExecutionString = "cmake" + " " + LocalCMakeArgs
            print("CMAKE CALL: " + ExecutionString)
            RunAndWait(ExecutionString, "../" + p['ModuleName'] + "_CMAKE" )
            
            if SystemName == 'Windows':
                SolutionName = None
                SolutionName = glob.glob("./" + VSMakeBuildFolder + "/*.sln")[0]
                VSExecutionString = VSBinPath + " " + SolutionName + " /build Release /project INSTALL"
                print("VS CALL: " + VSExecutionString) 
                RunAndWait(VSExecutionString, "../" + p['ModuleName'] + "_BUILD" )            
            else:
                MakeExecutionString = "make -j" + OSCPUCount + " --directory build install"
                print("MAKE CALL: " + MakeExecutionString) 
                RunAndWait(MakeExecutionString, "../" + p['ModuleName'] + "_BUILD" )
            
            os.chdir("../")
            print('')


