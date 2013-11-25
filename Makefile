DESTINATION   := ${HOME}
STOW_OPTIONS  := -v -t ${DESTINATION}
NEOBUNDLE_URL := https://github.com/Shougo/neobundle.vim.git
OH_MY_ZSH_URL := https://github.com/robbyrussell/oh-my-zsh.git
UNAME         := $(shell uname)

VERBOSE ?= FALSE
STOW_VERBOSE_FALSE = @echo "- STOW   " $@;
STOW_VERBOSE       = $(STOW_VERBOSE_$(VERBOSE))
GIT_VERBOSE_FALSE  = @echo "- GIT    " $@;
GIT_VERBOSE        = $(GIT_VERBOSE_$(VERBOSE))



.PHONY = \
	clean \
	stow \

all: \
	git \
	ack \
	neobundle \
	vim \
	zsh \

oh_my_zsh: zsh/.oh-my-zsh

zsh/.oh-my-zsh:
	$(GIT_VERBOSE) git clone $(OH_MY_ZSH_URL) zsh/.oh-my-zsh

zsh: $(DESTINATION)/.oh-my-zsh

$(DESTINATION)/.oh-my-zsh:
	$(STOW_VERBOSE) stow $(STOW_OPTIONS) zsh

neobundle: vim/.vim/bundle/neobundle.vim

vim/.vim/bundle/neobundle.vim:
	$(GIT_VERBOSE) git clone $(NEOBUNDLE_URL) vim/.vim/bundle/neobundle.vim

vim: $(DESTINATION)/.vimrc

$(DESTINATION)/.vimrc:
	$(STOW_VERBOSE) stow $(STOW_OPTIONS) vim

stow:
ifeq ($(UNAME), Linux)
	sudo apt-get install stow || true
endif
ifeq ($(UNAME), Darwin)
	brew install stow || true
endif

git: $(DESTINATION)/.gitconfig

$(DESTINATION)/.gitconfig:
	$(STOW_VERBOSE) stow $(STOW_OPTIONS) git

ack: $(DESTINATION)/.ackrc

$(DESTINATION)/.ackrc:
	$(STOW_VERBOSE) stow $(STOW_OPTIONS) ack

clean:
	$(STOW_VERBOSE) stow $(STOW_OPTIONS) -D $(wildcard */)
