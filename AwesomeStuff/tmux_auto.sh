#!/bin/bash
tmux new-session -d 'zsh'
tmux split-window -h
tmux split-window -v 'htop'
tmux new-window -d 'zsh'
tmux -2 attach-session -d 
