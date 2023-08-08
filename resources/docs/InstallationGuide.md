# Web-Application Prerequisites Installation Guide for Linux

This document provides you with a list of softwares necessary for our project and guides for how to download them onto your local machine

<br>

## **Table of Contents**

1. Homebrew
2. Maven
3. Docker
4. MiniKube

<br>

- ## **Homebrew**

  If you do not already have Homebrew installed this will be used to cleanly and accurately install of of the following dependencies

  ### **Install Homebrew Dependencies**

  1. Check if `make` is installed, by using the following command:

     ```bash
     make --version
     ```

  2. Update the package lists for upgrades and new package installations by running the following command:

     ```bash
     sudo apt update
     ```

  3. Install the necessary packages that allow Homebrew to work on Ubuntu:

     ```bash
     sudo apt install build-essential
     ```

  4. For Homebrew to install correctly it needs Git. Use the following command to install Git on Linux:

     ```bash
     sudo apt install git-all
     ```

  ### **Install Homebrew Dependancies**

  1. Download and install Homebrew by running the installation command provided on the Homebrew website. This command will download and execute the installation script for Homebrew.

     ```bash
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```

     During the installation process, you may be prompted to enter your password. Provide your password and press **Enter** to continue.

  2. After the installation, set the path for Homebrew. Use the command below to add the path to the .profile in your home directory. Remember to replace **<username>** with your username.

     ```bash
     echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/<username>/.profile
     ```

  3. To Verify the Homebrew installation by running the following command. If Homebrew is installed correctly, you should see a message indicating that your system is ready to brew.

     ```bash
     brew doctor
     ```

<br>

- ## **Maven**

  ### **Install Maven and Update Java**

    1. Since you already have Homebrew installed installing Maven is quick and easy. Use the following command below:

         ```bash
         brew install maven
         ```

         NOTE: _If needed place `sudo` before the command to give the command root authorization to change your file system_

    2. If properly installed. You should be able to type the command below and see your version of Maven:

         ```bash
         mvn -v
         ```


  ### **Check if Java Updated**

   Maven by default also updates your version on Java so if you type the command below you should see that your Java JDK upgraded to a version higher than the default Java 11 that comes pre-installed on Ubuntu.

    ```bash
    java -version
    ```

<br>

- ## **Docker**

  ### **Use alternate documentation to re-install Docker**

    1. To uninstall old versions of Docker and re-install Docker use the documentation here: https://docs.docker.com/engine/install/ubuntu/

    2. Make sure you can successfully run the `docker run hello-world` command

  ### **Give yourself admin privileges on Docker commands**

    3. Add your user to docker so you can execute docker commands without using `sudo`. Paste the following command and replace the last argument with your username. If you do not know your username type `id` in your terminal

       ```bash
       sudo usermod -a -G docker <computer-username>
       ```

<br>

- ## **MiniKube**

  ### **Install Minikube using Homebrew**

  - Make sure you have Kubernetes installed if not you can check if its installed typing `kubectl version`

  - If nothing comes up that means you do not have minikube installed so use Homebrew to install it by using the following command `brew install minikube`

  ### **Check if Minikube is installed**

  - You can check if Minikube installed by typing `minikube version`

  - If done correctly you should see the following output:

    ```bash
    minikube version: v1.30.1
    ```
