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
    3. git pull

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
    git commit --amend 修改commit信息
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
