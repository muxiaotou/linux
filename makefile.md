# 示例一
    make -f Makefile，Makefile内容如下：
    
    .PHONY: pull git_code build_code upload clean no_build no_build all
    
    SCM_PATH := $(shell pwd)
    CMPT_LIST := ${CMPT_LIST}
    CMPT_DIR := ${CMPT_DIR}
    component_name := ${component_name}
    
    DOCKER_IMAGE ?= image.mutouchen.com:5000/library/centos7-ansible-go1.8.3-fpm:centos7-ansible-go1.8.3-fpm
    
    pull:
    	docker pull $(DOCKER_IMAGE)
    
    git_code:
    	/bin/sh ./ci/dist/build/git_code.sh "${BRANCH}" "2" "${code1_branch}" "${code1_commitid}" "${common_branch}" "${common_commitid}"
    
    build_code:
    	/bin/sh ./ci/dist/build/build_code.sh "${BRANCH}" "2" "${code1_branch}" "${code1_commitid}" "${common_branch}" "${common_commitid}"  
    
    upload:
    	sh ./ci/dist/upload.sh
    
    clean:
    	/usr/bin/rm -rf $(abspath $(SCM_PATH))/src/mutouchen.com/*
    
    no_clean: pull build_code upload
    
    no_build: pull git_code
    
    all: pull build_code upload clean
    
# 示例二
    all: libs test
    
    libs: src/api-cgo.go
    	@go build -buildmode=c-archive -o lib/api.a src/api-cgo.go
    	@mkdir -p include
    	@mv lib/api.h include/api.h
    smoke.o: test/smoke.cpp
    	@g++ -I . -std=c++11 test/smoke.cpp -c
    test: smoke.o
    	@g++ smoke.o lib/api.a -lpthread -o api_smoke
    	@rm -f smoke.o
    clean:
    	@rm -f lib/api.a include/api.h
    	@rm -f api_smoke

# 示例说明
    .PHONY：伪目标， Makefile target默认是文件，如果在当前目录下与target同名的文件存在，则target下的command不会被执行，可以将target什么为伪目标，make
    就不会去检查是否存在一个叫做target的文件，而是每次都执行target下对应的命令
    
    Makefile文件由一系列规则构成，规则形式如下：
    <target> : <prerequisites> 
    [tab]  <commands>
    冒号前面部分叫做“目标”，不可省略；
        目标一般是文件名，也可以如示例是某个操作的名字(伪目标)
    “前置条件”和“命令”都是可选的，但两者必须至少存在一个；
        “前置条件”通常是一组文件名，用空格分隔，在make target时，会先先依次执行后面的“前置条件”，切记要确保“前置条件”对应的target存在
    
    @ make会打印每条命令，然后执行，这叫做回声，命令前加上@可以关闭回声
    
    赋值：
    = 最基本的赋值
    := 在定义时扩展
    ?= 只有在该变量为空时才设置值
    