FROM osrf/ubuntu_arm64:focal
ENV DEBIAN_FRONTEND=noninteractive
ARG HOME=/root

# Pre-requisite
RUN sudo apt-get update && sudo apt-get -y upgrade 
RUN sudo apt-get -y install tmux curl wget curl net-tools git nano
RUN sudo touch /ros_entrypoint.sh

# ROS
RUN apt-get update
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update && \
    apt-get -y install ros-noetic-desktop-full 
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# mavros
RUN sudo apt-get -y install ros-noetic-mavros ros-noetic-mavros-extras ros-noetic-mavros-msgs libncurses5-dev python3-pip libgstreamer1.0-dev python-jinja2 python3-pip python3-testresources libignition-math4 libgazebo11-dev
RUN sudo apt-get -y upgrade libignition-math4
RUN wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
RUN sudo bash ./install_geographiclib_datasets.sh

# SSH
RUN sudo apt-get update
RUN sudo apt-get -y install openssh-server
# RUN echo -e "0000\n0000" | passwd root
RUN sudo echo "PermitRootLogin Yes" >> /etc/ssh/sshd_config
RUN sed -i 's/\(^Port\)/#\1/' /etc/ssh/sshd_config && echo Port 6666 >> /etc/ssh/sshd_config
RUN sed -i '4i\service ssh start' /ros_entrypoint.sh 

# NGROK
WORKDIR /
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok
RUN touch ngrok.sh
RUN echo "cd /usr/local/bin">> /ngrok.sh
RUN echo "./ngrok tcp 6666">> /ngrok.sh
RUN chmod +x ngrok.sh

# GIT Update
RUN sudo apt install software-properties-common -y
RUN sudo add-apt-repository -y ppa:git-core/ppa
RUN sudo apt update
RUN sudo apt install git -y

WORKDIR $HOME