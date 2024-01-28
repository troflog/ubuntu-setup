ssh -L 6666:localhost:6666 mininet nvim --headless --listen localhost:6666
nvim --server localhost:6666 --remote-ui
