# AWS AMI for CSYE 6225

## Team Information


| Name | NEU ID | Email Address |
| --- | --- | --- |
| Kinjal Patel| 001831447 | patel.kin@husky.neu.edu|
| Siddhesh Kuvalekar| 001238765| kuvalekar.s@husky.neu.edu|
| Mahalakshmi Arunachalam| 001810136 | arunachalam.m@husky.neu.edu|
| Karan Mahaddalkar| 001821603 | mahaddalkar.k@husky.neu.edu |
## Validate Template

```
packer validate  centos-ami-template.json
```

## Build AMI

```
packer build 
    centos-ami-template.json
```
