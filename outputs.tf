# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.ebanking.address
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.ebanking.port
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.ebanking.username
}

output "rds_replica_connection_parameters" {
  description = "RDS replica instance connection parameters"
  value = "mysql -h ${aws_db_instance.ebanking.address} -u ${aws_db_instance.ebanking.username} -p"
}