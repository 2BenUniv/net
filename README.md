# Have you ever missed covid test?
If you did, probably you have already experienced internet block and canvas lock.

This project is to help regain internet access.

## start ssh
connect you computer to cornell wifi (eduroam) (even if you loose internet connection)

If you are mac user, open terminal. If you are windows user, open powershell (press win + R and type powershell)

(If you are a linux user, probably you should already know how to do)

then type `nslookup ugclinux.cs.cornell.edu` and press enter.
you may get something like this:
```
Addresses:  132.236.91.187
          132.236.91.182
          132.236.91.181
          132.236.91.183
          132.236.91.185
          132.236.91.179
          132.236.91.180
          132.236.91.188
          132.236.91.184
          132.236.91.186
```

pick any one you like. (for example I may choose `132.236.91.180`) (and write down somewhere as you may need it later)
then type `ssh YOUR_NETID@132.236.91.180`(replace `YOUR_NETID` with your netid!), type `yes` and press enter if it asks you to recognize some fingerprint.
type your password and press enter.

## install proxy

then type this and press enter 
```
bash <(curl -s https://raw.githubusercontent.com/2BenUniv/net/main/setup.sh)
```
it will automatically start install proxy

after success it may show something like this
```
connection address: 132.236.91.180
socks5 port: 12345
http port: 12346
```
(this is just an example, use your own for your configuration or it won't work)

## config you computer

For mac user:
click on the wifi icon on the menu bar (the thing on the top of your screen), click on `preference`, on the poped up windows, click on `Advanced`, click on `proxy`. choose `socks5 proxy`, on the right side, enter the address from previous step before `:`, enter the socks5 port from previous step after the `:`, save and apply all the settings.

For windows user:
Go to windows settings (press Win + i), go to `Network and Internet`, go to `Proxy`, in the `Manual proxy setup`, turn on `use a proxy server`, enter the address from previous server for `Address`, enter the http port from previous step for `port`

Now you should be able to access the internet.

## after eveerything

When you finally make up the test and no longer need proxy. follow the ssh step, login in to the exactly same server (address) as you choose before.
type `ineedwifi stop`, this will shutdown the proxy.

When you forget covid test again and need this again, follow the ssh step, login in to the exactly same server (address) as you choose before.
type `ineedwifi start`, this will start the proxy.



