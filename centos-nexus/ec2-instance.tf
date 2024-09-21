#############################
# Data Source
##############################

data "aws_ami" "centos-9-stream" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS-Stream-ec2-9-*x86_64-*"] # Match the CentOS 9 Stream AMI
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

##############################
###  EC2 Instance 
#############################

resource "aws_key_pair" "container-key" {
  key_name   = "container-key"
  public_key = file("container-key.pem.pub")
}

resource "aws_instance" "container-ec2" {
  ami                    = data.aws_ami.centos-9-stream.id
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.container.id
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  key_name               = aws_key_pair.container-key.key_name

  user_data = <<-EOF
    #!/bin/bash
    yum install java-17-openjdk wget -y  # Install latest Java 
    mkdir -p /opt/nexus/
    mkdir -p /tmp/nexus/                           
    cd /tmp/nexus/
    NEXUSURL="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"
    wget $NEXUSURL -O nexus.tar.gz
    sleep 10
    EXTOUT=`tar xzvf nexus.tar.gz`
    NEXUSDIR=`echo $EXTOUT | cut -d '/' -f1`
    sleep 5
    rm -rf /tmp/nexus/nexus.tar.gz
    cp -r /tmp/nexus/* /opt/nexus/
    sleep 5
    useradd nexus
    chown -R nexus.nexus /opt/nexus 
    cat <<EOT> /etc/systemd/system/nexus.service
    [Unit]                                                                          
    Description=nexus service                                                        
    After=network.target                                                             
                                                                    
    [Service]                                                                        
    Type=forking                                                                     
    LimitNOFILE=65536                                                                
    ExecStart=/opt/nexus/$NEXUSDIR/bin/nexus start                                   
    ExecStop=/opt/nexus/$NEXUSDIR/bin/nexus stop                                     
    User=nexus                                                                       
    Restart=on-abort                                                                 
                                                                    
    [Install]                                                                        
    WantedBy=multi-user.target                                                       
    EOT

    echo 'run_as_user="nexus"' > /opt/nexus/$NEXUSDIR/bin/nexus.rc
    systemctl daemon-reload
    systemctl start nexus
    systemctl enable nexus
  EOF

  tags = {
    Name = "nexus-server"
  }
}

output "publicIP" {
  value = aws_instance.container-ec2.public_ip
}
output "privateIP" {
  value = aws_instance.container-ec2.private_ip
}
