# Use a lightweight Fedora base image
FROM fedora:latest

# Install C development tools and libraries
RUN dnf install -y gcc clang gdb valgrind make autoconf automake
RUN dnf install -y gtk3-devel gstreamer1-devel clutter-devel webkit2gtk3-devel libgda-devel gobject-introspection-devel
RUN dnf groupinstall -y "Development Tools" "Development Libraries"
# Install additional dependencies for code-server
RUN dnf install -y curl git

# Install code-server (VS Code in the browser)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Expose the code-server port
EXPOSE 8080

# Set up the environment for code-server
ENV PASSWORD="your_password"  
ENV USER="coder"

# Create a user for code-server
RUN adduser $USER
USER $USER

# Set the working directory
WORKDIR /home/$USER

# Start code-server
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password"]
