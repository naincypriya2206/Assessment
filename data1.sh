#!/bin/bash
sudo yum update
sudo yum install nginx
sudo systemctl statart nginx
sudo systemctl enable nginx