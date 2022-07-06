    git clone -b dev git@beibei.com/code.git  克隆指定branch
    git reset --hard ${commitid} 回退到指定commit
    git clean --df 删除指定路径下没有被track过的文件，配合reset使用，reset只影响被track过的文件
    git rev-parse HEAD  /  git rev-parse --short HEAD   获取commit
    git diff dev master --name-only 打印两个branch之间的变更，仅显示文件名
    git fetch  将远程主机的最新内容拉到本地
    git pull 将远程主机的最新内容拉下来后与当前分支合并，即git pull = git fetch + git merge
    
    【合并多个commit】
    1.checkout到分支
    2.git rebase -i HEAD~2或 git rebase -i COMMITID
    3.p 保留该commit， s 将该commit与前一个commit合并
    
    【避免挨个commit对比合并的方法】
    1.checkout到分支
    2.git pull origin master
    3.处理冲突(仅仅使用最终版本和master进行合并，不会出现类似rebase一样每个commit都进行比较)
    4.git commit
    5.git push origin 分支
    
    【撤销本地修改】
    git reflog
    git reset --hard HEAD@{13}
    
    给所在仓库设置name和email，如果设置所有仓库，加上--global参数
    git config user.name "muxiaotou"
    git config user.email "cl340266909@163.com"
    git config --local --list
    
    【https和ssh协议】
    一般git clone或者git push，会遇到git@xxx或者https@xxx
    git@使用ssh协议，可以将本地的公钥加到github上面，本地后面pull、push均免密
    https@每次push或者pull，均需要输入密码

    【rebase和merge区别】
    git rebase master 会改变每条提交的commit id

    【强制拉取远端代码覆盖本地代码】
    1. git fetch --all
    2. git reset --hard origin/master  (此处master为分支，根据实际情况进行修改)
    3. git pull origin master
    其实直接git pull --force origin master:master即可

    【origin、local branch同步】
    git remote show origin   查看本地与远端的分支跟踪情况
    git remote prune origin 从本地删除远端已经不存在的branch的跟踪
    git  branch -D BRANCH_NAME  删除本地分支
    git push origin --delete dev  删除远端dev分支

    【git add . 和git add --all 区别】
    1）1.x版本 git add --all 可以提交未追踪、修改和删除的文件；git add .可以提交未追踪、修改的文件，但不处理删除的文件
    2）2.x版本 git add --all和git add .都可以提交未追踪、修改和删除的文件
    3）git add --all无论在哪个目录都会提交响应的文件；git add .只能够提交当前目录或者它子目录下的响应文件
    
    【常用的git命令整理】
    git add -A/git add --all
    git commit -am ""
    git commit --amend 修改上次commit信息，也可以多次修改后，放入同一次commit当中，比如：
    git add 后，git commit --amend --no-edit或者git commit --amend，这样就讲本次修改同上次修改合入同一个commit里面了
    git push origin master

    git init  初始化本地仓库，远程仓库叫做origin
    git remote -v  显示远程仓库
    git remote add URL  将本地仓库与远程仓库关联
    git remote set-url origin URL 修改本地仓库关联的远程仓库

    git clone 克隆一个远程仓库
    git branch 列出本地分支
    git branch <NAME> 新建本地分支
    git checkout <NAME> 切换分支
    git checkout -b <NAME> 新建一个分支并切换过去

    git checkout master; git merge dev   切换到master，然后把dev分支合并到master

    git pull origin master  拉取远端的master分支到当前的本地分支
    git status 查看当前分支哪些文件被修改、未被追踪等
    git diff --stat 列出不同，仅列出文件名，默认列出文件内容变化

    git log 提交历史
    git push origin master -f  强制覆盖远端分支

    git rebase -i HEAD^4 合并提交

    git show <commit> 显示指定commit的提交内容，commit未指定时默认未HEAD,即最后一次提交

    
#### https://mp.weixin.qq.com/s/a7ChQILEtd6TUHYy5GCFeA 
1. 在某个节点创建一个分支后，并不会把该节点对应的代码复制一份出来，只是将新分支指向该节点，因此很大
    程度减少空间上的开销。 
2. git中文件分为三种状态：modified、staged、commited，已修改、已暂存、已提交
3. HEAD 是git中非常重要的一个概念，可以理解为它是一个指针或者引用，它可以指向任意一个节点，并且指
   向的节点始终为当前工作目录，换句话说就是当前工作目录，也就是所看到的代码就是HEAD指向的节点
4. 一些命令
    git checkout -- 文件名   //撤销工作区某个文件的改动
    git reset HEAD 文件名    //清空暂存区
5. 合并命令  merge、rebase、cherry-pick
    git merge 分支名/节点哈希值  //将某个分支或者某个节点的代码合并至当前分支，当两个分支有冲突时，合并生成一个新的节点
    git rebase 分支名/节点哈希值 //表明看起来不会产生新的节点(实际commit会变)，将需要合并的节点直接依次按照提交历史进行累加
    merge优缺点：
    每个节点都严格按照时间顺序，当合并发生冲突时，只需要解决两个分支所指向的节点的冲突(即只需要一次解决所有冲突)
    rebase优缺点：
    按照时间顺序依次累加，提交历史看起来比较线性、干净。缺点就是当不同分支commit冲突较多时，每个commit均需多次处理冲突
   
    git cherry-pick 节点哈希值  //将提供的节点合并到当前分支，支持一次合并多个节点
6. clone fetch pull  push 
    clone 将远程仓库的所有提交、引用保存在本地一份，但后续的变更，不会实时同步本地，需要在本地执行git fetch 去主动获取
    fetch 通俗一点就是一次下载操作，会将远程新增加的节点以及引用(分支/HEAD)的状态下载到本地， git fetch 远程仓库地址/分支名
    pull  本质就是fetch+merge，即将远端对应代码拉取下来后与本地当前分支代码合并
   
    git  fetch  //拉取远端所有分支的变更到本地，但不会更新本地仓库的版本状态，
        因此还需要checkout到分支里面，git pull origin <branch>来同步远端修改到本地
    git  pull   //拉取远端所有分支的变更到本地，并更新本地仓库的版本状态
    
    