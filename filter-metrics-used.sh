rg aws_cloudwatch | grep -Eo "aws_cloudwatch_\S+" | tr "_" " " | awk '{ print $3 " " $4; }' | sort | uniq
