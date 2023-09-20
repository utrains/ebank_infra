#terraform.tfvars
db_password = "utrainsHashicorp"

aws_region = "us-west-2"
aws_instance_type  = "t2.medium"
aws_key = "my_ec2_key"
qa_server = true
prod_server = true
nexus_server = true
profile = "default"
jenkins_ami = "ami-06afcaf5287e6c18e"
nexus_ami   = "ami-06afcaf5287e6c18e"
prod_ami   = "ami-06afcaf5287e6c18e"
qa_ami   = "ami-06afcaf5287e6c18e"

# ami-0800600314f6e9145	maven-java-node
#ami-06afcaf5287e6c18e	h90-jenkins-img