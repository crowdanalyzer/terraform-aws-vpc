# Bastion Host Terraform Module

This terraform module launches a single EC2 instance that is meant to serve as bastion host. A bastion host is a security best practice where it is the *only* server exposed to the public. You must connect to it via SSH before you can connect to any of your other servers, which are in private subnets. This way, you minimize the surface area you expose to attackers, and can focus all your efforts on locking down just a single server.

---

## Why a Bastion Host?

Your team will need the ability to SSH directly to EC2 Instances. *Should we then make these EC2 Instances publicly accessible to the Internet*? The answer is **No**, because then we have multiple servers that represent potential attack vectors into your app. Instead, the best practice is to have a single server that's exposed to the public **-- a bastion host --** on which we can focus all our efforts for locking down. It is a "bastion" or fortress on which we focus all our security resources versus diluting our efforts across multiple servers. As a result, we place the bastion host in the public subnet, and all other servers should be located in private subnets. Once connected to the bastion host, you can then SSH to any other EC2 Instance.

---

## SSH Access

Once you are logged into the Bastion Host, you are effectively *in the network* and you can then SSH from the Bastion Host to any other EC2 instance in the account, including those in the private subnets of the VPC. Since it takes two "hops" to SSH to your servers, the Bastion Host is often called an "SSH Jump Host" or "Jump Box." The tricky part with jump hosts is that, while you have your SSH keys on your local computer, the bastion host does not. To avoid copying keys around **(which is a huge security risk!)**, the best way to work with a jump host is to use SSH Agent. ssh-agent runs on your local machine and is responsible for keeping all your private SSH keys in memory. When you SSH to another instance, if ssh-agent is running and you don't explicitly specify a local key file to use for authentication, your ssh-agent will automatically try each of your keys one by one to log into the instance. Don't worry, your private keys are never transmitted; only used to participate in the SSH authentication process. A companion tool to ssh-agent is ssh-add. You can use ssh-add to add some or all of your local SSH Keys to local memory (note: if you add too many keys, you may get an error like "ran out of authentication methods to try" before it finds your key). Then, when you connect to the jump host with the -A option, your SSH keys will also be available on the jump host. For example, let's say bastion-v1.pem was your Key Pair for the bastion host and ec2-instances-v1.pem was your Key Pair for the EC2 instances in the VPC. Here is how you could use SSH Agent to connect to an ec2 instance in the VPC:

```shell
ssh-add 'ec2-instances-v1.pem'
ssh -A -i 'bastion-v1.pem' ec2-user@<BASTION-IP-ADDRESS>

# Now you're on the bastion host
ssh ec2-user@<EC2-INSTANCE-PRIVATE-IP-ADDRESS>

# Now you're on the EC2 instance
```

---

## Using Port Forwarding with Your Bastion Host

When you connect via SSH to your Bastion Host, you may opt to expose certain ports using SSH Local Port Forwarding. For example, you could SSH to the Bastion Host with `ssh -L 8500:ec2-instance.com:8500 mylogin@bastion-host.com`, which will open a listener at `localhost:8500` which is routed to the Bastion Host where it is then further routed to `ec2-instance.com:8500` from the Bastion Host. As a result, just by connecting to `http://localhost:8500` from your local machine, you could view, for example, the UI running on port `8500` on the private instance.
