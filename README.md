![Build Status](https://travis-ci.org/vdorr/hs-mini-netmap.svg?branch=master)
# hs-mini-netmap
ping a lot

to send ping on linux (that is, to use raw sock), certain capabilities are required:
    sudo setcap cap_net_raw+pe FILE
or run as superuser, the former is strongly advised

