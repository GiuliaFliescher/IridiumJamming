# IridiumJamming
For this project I installed gnu radio companion, gr-iridium, gr-limesdr and limesuite.

Follow instructions here to install gnu radio: https://github.com/gnuradio/pybombs.

To install gr-iridium run the following:
```
git clone https://github.com/JosWigchert/gr-iridium
cd gr-iridium
cmake -B build
cmake --build build -j 2
sudo cmake --install build
sudo ldconfig
```

To start run ```source prefix-3.10/setup_env.sh``` 
tbc
