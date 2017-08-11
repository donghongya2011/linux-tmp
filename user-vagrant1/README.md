# 用户端开发环境搭建 #

在开始安装环境之前，十分无理的要求一下各位使用ubuntu的同学们关机重启进入bios，mac用户直接忽略这一步  
先上两张图  

![bios配置vtx1](img/bios_vtx1.jpeg?raw=true)

![bios配置vtx2](img/bios_vtx2.jpeg?raw=true)

进入bios后首先打开"Security"中的"System Security"  
然后把其中的"Virtualization Technology（VTx）"从"Disable"改成"Enable"  
这一步很重要，假如不做，无法完成后续安装  

## 准备环境（安装5个软件）

首先，我们墙裂建议各位使用的大神们确认一下自己的PC上是否已经安装了如下软件  
再罗嗦一句，这里我们只是为大家提供了一个下载安装包的地址（绝不是只是把下面的wget命令做完就安装好了），具体的安装大家还要根据不同的安装包进行安装  

* ###ansible 1.4 +

```
# linux环境
# wget http://soft.dev.aifang.com/ansible-1.4.4.tar.gz
# tar zxvf ansible-1.4.4.tar.gz
# sudo python setup.py install
# 
# 如果安装顺利执行 ansible --version 会显示当前ansible的版本号，但是也有可能会遇到python的依赖包缺失报错，大致有以下2类：
# 1. 缺失jinja2
# sudo apt-get install python-jinja2
# 2. 缺失yaml
# sudo apt-get install python-yaml
```
```
# mac环境
# brew install ansible
```
* ###Vagrant 1.4 +

```
# linux环境
# wget http://soft.dev.aifang.com/vagrant_1.4.3_x86_64.deb
# sudo dpkg -i vagrant_1.4.3_x86_64.deb
```
```
# mac环境
# wget https://dl.bintray.com/mitchellh/vagrant/Vagrant-1.4.3.dmg
```

* ###Virtualbox 4.3 +

```
# linux环境
# wget http://soft.dev.aifang.com/virtualbox-4.3_4.3.6-91406~Ubuntu~precise_amd64.deb
# sudo dpkg -i virtualbox-4.3_4.3.6-91406~Ubuntu~precise_amd64.deb
```
```
# mac环境
# wget http://download.virtualbox.org/virtualbox/4.3.6/VirtualBox-4.3.6-91406-OSX.dmg
```

* ### git

```
# 默认你会装，并且已经装过了啊
```

* ### svn

```
# svn很淡疼，但是还是装一下吧
```


## 首次启动 ##

执行引导程序：

```
# git clone git@git.corp.anjuke.com:kakiezhang/user-vagrant
# cd user-vagrant
# bash getUserSite.sh 
#
# user-vagrant这个目录下面的getUserSite.sh这个脚本只需要执行第一次(且只有这一次)，以后的操作就都用vguser这个命令去完成吧
# 执行脚本当中会有提示输入工作目录，切记工作目录不可与安装脚本的目录放在同一级目录下
```


## 第N次启动

```
# vguser
# 常用参数举例：
# 关机重启后需要启动vagrant：vguser reload
# 停止运行vagrant：vguser halt
# 关于这个命令的用法参数还有很多，这里不一一举例了，大家安装完后直接输入vguser会有详细的用法
```


* 如在安装过程中有遇到任何不爽或者问题，请找 张弦 / 倪建强 协助解决
