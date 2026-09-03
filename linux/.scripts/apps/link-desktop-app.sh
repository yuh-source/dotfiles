for f in ~/Desktop/*.desktop; do
    ln -sf "$f" ~/.local/share/applications/
done