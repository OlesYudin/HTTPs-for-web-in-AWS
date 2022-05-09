Youtube guide: https://www.youtube.com/watch?v=bWPTq8z1vFY

Create domaine
Register Domaine in AWS Route53
Create certificate for TLS in AWS Certificate Manager
Create EC2 intstance
Create ALB and Target Groups
Associate target group with instance
Create new recoder in Route53

## Create domaine

Create your domaine. You can buy it in AWS in Route53 or buy in other place. Also you can take fo free domaine for 1 year, for example in [myFreenom](https://my.freenom.com/clientarea.php "myFreenom").

## Register domaine in AWS Route53

You need to register your domaine in [AWS Route53](https://aws.amazon.com/route53 "AWS Route53").

1. Click on `create hosted zone`

<p align="center">
  <img src="images/1. Create hosted zone.png" alt="Create hosted zone"/>
</p>

2. You will see configuration menu like this (in future GUI can be changed)

<p align="center">
  <img src="images/2. Procces of creation hosted zone.png" alt="Procces of creation hosted zone"/>
</p>

- Write your domaine name
- Write description if you want
- Choose type of hosted zone. If you need associate hosted zone with [AWS VPC](https://aws.amazon.com/vpc/ "AWS VPC") - use `private hosted zone`, else use `public hosted zone`
- Add tag if it necessary
- Click on `create hosted zone`

<p align="center">
  <img src="images/3. Hosted zone.png" alt="Menu of hosted zone"/>
</p>

3. When you create hosted zone youu will see 2 records: [NS (Name server)](https://www.cloudns.net/wiki/article/34/ "NS (Name Server)"), [SOA (Start Of Authority)](https://en.wikipedia.org/wiki/SOA_record "SOA (Start Of Authority)"). From NS you should write `value`.

   In my case it is:

- ns-329.awsdns-41.com.
- ns-527.awsdns-01.net.
- ns-1599.awsdns-07.co.uk.
- ns-1298.awsdns-34.org.

4. Value from NS record you need to register in your **Domaine Service**, which you create [here]("here").

In my case it is look something like this

<p align="center">
  <img src="images/4. Register nameservers in Domaine service.png" alt="Register nameservers in Domaine service"/>
</p>

Congratulations! If you use free domaine, you register you domain in AWS Route53 without **extra pay**!

## Create certificate for domaine

1. Open [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/ "AWS Certificate Manager") and click on `Reguest a certificate`.

<p align="center">
  <img src="images/5. Request a certificate from AWS CM.png" alt="Request a certificate from AWS CM"/>
</p>

2. Click on `Request a public certificate`

<p align="center">
  <img src="images/3. Request public cert in AWS SM.png" alt="Request a public certificate in AWS SM"/>
</p>

3. Write full name of domaine, than choose validation method. If you use `DNS validation` - you will add extra record on Route53 to validate your domaine from AWS (it is \*recommended\*\* way). If you use `Email validation` - you will recive validation massage on your domaine email (for example: admin@lisenok-aws.tk). Than choose tags if it necessary for you and click `Request`.

<p align="center">
  <img src="images/7. Request public cert in AWS CM (2).png" alt="Request public certificate in AWS CM"/>
</p>

4. You will see Domains something like this. You need copy `CNAME name` and `CNAME value`.

<p align="center">
  <img src="images/8. Certificate domaine.png" alt="Certificate domaine"/>
</p>

5. Now you certificate has "pending" status. You need to create new record on [AWS Route53](https://aws.amazon.com/route53 "AWS Route53"). Return to Route53, choose your `hosted zone` and click on `Create record`.

<p align="center">
  <img src="images/9. Create record in Route53.png" alt="Create new record in Route53"/>
</p>

6. When you create new record, you need:

- Paste `CNAME name` to `Record name`. Be carefull, and remove from CNAME your domaine name. For example, in my case I remove `.lixenok-aws.tk.`.
- Choose `CNAME - Routes traffis to another domaine name and to some AWS resources` as a `record type`
- Paste `CNAME value` to `value`
- click on `Create records`

<p align="center">
  <img src="images/10. Create CNAME record in Route53.png" alt="Create CNAME record in Route53"/>
</p>

7. Wait 1-2 minutes and your certificate will have `Success` status

<p align="center">
  <img src="images/11. Success AWS CM.png" alt="Success status on AWS CM"/>
</p>

## Create EC2 instance

1. Search [EC2](https://aws.amazon.com/ec2/ "EC2") service and click on `Launch instance`

<p align="center">
  <img src="images/12. Launch instance one AWS EC2.png" alt="Launch instance one AWS EC2"/>
</p>

2. Now you need to create AWS EC2 instance.

2.1 Choose name of EC2, OS and instance type.

<p align="center">
  <img src="images/13. Choose name of AWS EC2.png" alt="Choose name of AWS EC2"/>
  <img src="images/14. Choose OS and instance type of EC2.png" alt="Choose OS and instance type of AWS EC2"/>
</p>

2.2 Choose `key pair` if you want to SSH conncection to server. If it is your first type, firtsly create key pair and download private key, you will need that key wor SSH conncection.

<p align="center">
  <img src="images/15. Create SSH key for AWS EC2.png" alt="Create SSH key for AWS EC2"/>
  <img src="images/16. Choose SSH key for AWS EC2.png" alt="Choose SSH key for AWS EC2"/>
</p>

2.3 Create `Security group`. If you need SSH connection, open 22 port. Also you will need HTTP and HTTPs port (80, 443).
**Security Group (SG)** - it is AWS Firewall for your webservers. Input nesessary ports, choose protocol and choose source. **Source** - it is destination IP-address that will allow traffic, if you want allow traffic from all IP in the Internet use **0.0.0.0/0**

Also choose network.

<p align="center">
  <img src="images/17. Create SG for AWS EC2.png" alt="Create Security Group for AWS EC2"/>
  <img src="images/18. Choose network for AWS EC2.png" alt="Choose network for AWS EC2"/>
</p>

2.4 Choose size and type of your storage.
AWS has differant types of storage, you can reed about it [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AmazonEBS.html "here")

<p align="center">
  <img src="images/19. Choose storage for AWS EC2.png" alt="Choose storage for AWS EC2"/>
</p>

2.5 Add `user data`.
CLick on `Advance settings` and scroll down. Copy/paste [this]("") script and paste into `user data`. This script will be running after installation of OS and install to your server [Apache2](https://httpd.apache.org/ "Apache2"). Also you can customize this user data if nessecary.

<p align="center">
  <img src="images/20. User data for AWS EC2.png" alt="User data for AWS EC2"/>
</p>

3. Review your instance confguration and click `Launch instance`

<p align="center">
  <img src="images/21. Summary of AWS EC2 instance.png" alt="Summary of AWS EC2 instance"/>
</p>

## Create Load Balancer and Target Groups

Unfortunately, you can`t install SSL/TLS certificate to AWS EC2 instance, but you can attach certificate to load balancer and have **secure connection** to your web-appliaction.

1. Create Target Groups (TG)

Open [AWS EC2](https://aws.amazon.com/ec2/ "EC2") GUI console and scroll down throw navigation panel that located on left side. You will see menu `Load balancing`, click on `Target groups`, than click on `Create target group`.

<p align="center">
  <img src="images/22. Load balancing menu.png" alt="Load balancing menu"/>
  <img src="images/23. Create TG for ALB.png" alt="Create TG for ALB"/>
</p>

1.1 Choose targe type `instance`.

<p align="center">
  <img src="images/24. Choose target type for TG.png" alt="Choose target type for TG"/>
</p>

1.2 Write `name` for TG and choose protocol
In ths case, I use HTTP, because after ALB traffic will be **decrypt**.

<p align="center">
  <img src="images/25. Choose protocol for TG.png" alt="Choose protocol for TG"/>
</p>

1.3 Choose `health check` for you servers.
It is mean, that ALB will check if your server heathy, if now it can create new server or give you notification about server. In this example, I do not create "blue-green deployment" and do not give notification about servervs health. By default, I use HTTP protocol and path "/", it is mean that ALB will be checked **root** directory (index.html page) of web-application.

<p align="center">
  <img src="images/26. Create health check for TG.png" alt="Create health check for TG"/>
</p>

1.4 Register targets for TG
Priviously, we create AWS EC2 instance. Now, we can register this instance to the TG.
Secelt you instance and click on `Include ad pending below`.

<p align="center">
  <img src="images/27. Register AWS EC2 instance with TG.png" alt="Register AWS EC2 instance with TG"/>
  <img src="images/28. Register AWS EC2 instance with TG (2).png" alt="Register AWS EC2 instance with TG (2)"/>
  <img src="images/29. Creation of TG.png" alt="Creation of TG"/>  
</p>

2. Create Application Load Balancer (ALB)

You can choose what type of load balancer you want. AWS support [Classic Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/introduction.html "Classic Load Balancer") (Previous genetation) and [Application Load Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html "Application Load Balancer") for SSL/TLC certificates. In this project I use ALB.

2.1 Open [EC2](https://aws.amazon.com/ec2/ "EC2") and search `load balncing`. You will see `Load balancer`, go there and click `Create Load Balancer`.

<p align="center">
  <img src="images/30. Create ALB.png" alt="Create Application Load Balancer"/>
</p>
