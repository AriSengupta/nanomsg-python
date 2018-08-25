IF EXIST nanomsg-src (
echo nanomsg-src exists skipping clone 
) ELSE (
git clone https://github.com/nanomsg/nanomsg.git nanomsg-src
)

pushd nanomsg-src

if not defined DevEnvDir (
   call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x86
)
mkdir  build
cd build
cmake -G"Ninja" ..
cmake --build .
cmake --build . --target install
cd
xcopy /y nanomsg.lib ..\..
xcopy /y ..\src\*.h ..\..\include\nanomsg\
popd 
python setup.py install
python setup.py test
popd
