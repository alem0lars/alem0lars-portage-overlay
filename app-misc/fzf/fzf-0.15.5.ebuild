# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils

DESCRIPTION="A command-line fuzzy finder written in Go"
HOMEPAGE="https://github.com/junegunn/fzf"
SRC_URI="https://github.com/junegunn/fzf/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="
	bash-completion bash-keybindings
	zsh-completion zsh-keybindings
	fish-keybindings
	tmux
	vim
	doc
"

DEPEND="
	dev-lang/go
"
RDEPEND="${DEPEND}"

src_compile() {
	cd src
	emake install
}

src_install() {
	dobin bin/fzf

	doman man/man1/fzf.1

	if use bash-completion; then
		insinto /etc/bash_completion.d/
		newins shell/completion.bash fzf
	fi

	if use bash-keybindings; then
		insinto /etc/profile.d/
		newins shell/key-bindings.bash fzf.bash
	fi

	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions/
		newins shell/completion.zsh _fzf
	fi

	if use zsh-keybindings; then
		insinto /usr/share/zsh/site-contrib/
		newins shell/key-bindings.zsh fzf.zsh
	fi

	if use fish-keybindings; then
		insinto /usr/share/fish/functions/
		newins shell/key-bindings.fish fzf.fish
	fi

	if use tmux; then
		dobin bin/fzf-tmux
	fi

	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins plugin/fzf.vim
	fi

	if use doc; then
		dodoc README.md
	fi
}