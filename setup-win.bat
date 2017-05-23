@echo off

set NODE_VER=null

node -v >tmp.txt
set /p NODE_VER=<tmp.txt
del tmp.txt
echo %NODE_VER%

IF %NODE_VER% EQU null (
	echo NodeJs not installed.  Please install the latest LTS version of NodeJs from https://nodejs.org/en/download/
) ELSE (
	pushd Lesson2_CreateViewWithEventConsumer\winner-view
	call npm install
	popd
	pushd Lesson3_PublicEndpointToAccessView\winner-api
	call npm install
	popd
)

echo DONE!
