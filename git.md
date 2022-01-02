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
    