# Terraform Notes

## Terraform Version Manager (tfenv)

[tfenv](https://github.com/tfutils/tfenv) is a version manager utility for Terraform.

### Installation and usage

Install with [Homebrew](https://brew.sh/) on Mac:

```
brew install tfenv
```

List Terraform versions available for installation:

```
tfenv list-remote
```

Install a specific version:
```
tfenv install 1.4.6
```

Use an installed version:
```
tfenv use 1.4.6
```

## Terraform usage

Initialize an infrastructure:

```
terraform init
```

View the changes required:
```
terraform plan
```

Apply the changes:
```
terraform apply
```

Show the state of a resource or instance:
```
terraform state show <variable.name>
```

List instances:
```
terraform state list
```

Destroy running infrastructure:
```
terraform destroy
```


