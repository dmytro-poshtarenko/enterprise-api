resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${var.ecs_task_name}"
  retention_in_days = 7
}

resource "aws_ecs_cluster" "enterprise_cluster" {
  name = "enterprise-cluster"
}

resource "aws_ecs_task_definition" "app_task" {
  family = var.ecs_task_name
  container_definitions = jsonencode([
    {
      name : var.ecs_task_name,
      image : aws_ecr_repository.enterprise_api_ecr_repo.repository_url,
      essential : true,
      portMappings : [
        {
          containerPort : var.api_port,
          hostPort : var.api_port
        }
      ],
      memory : 512,
      cpu : 256,
      environment : [
        {
          name : "NODE_ENV",
          value : var.node_env
        },
        {
          name : "APP_BASE_URL",
          value : aws_alb.application_load_balancer.dns_name
        },
        {
          name : "PORT",
          value : tostring(var.api_port)
        },
        {
          name : "DATABASE_URL",
          value : "postgres://${aws_db_instance.postgres_instance.username}:${var.db_password}@${aws_db_instance.postgres_instance.endpoint}/${aws_db_instance.postgres_instance.db_name}"
        }
      ],
      logConfiguration : {
        logDriver : "awslogs",
        options : {
          awslogs-group : "/ecs/${var.ecs_task_name}",
          awslogs-region : var.aws_region,
          awslogs-stream-prefix : "ecs"
        }
      }
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = 512
  cpu                      = 256
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "app_service" {
  name            = "enterprise-service"
  cluster         = aws_ecs_cluster.enterprise_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn
  launch_type     = "FARGATE"
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = aws_ecs_task_definition.app_task.family
    container_port   = var.api_port
  }

  network_configuration {
    subnets          = [aws_default_subnet.default_subnet_a.id, aws_default_subnet.default_subnet_b.id]
    assign_public_ip = true
    security_groups  = [aws_security_group.service_security_group.id]
  }
}

resource "aws_security_group" "service_security_group" {
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.load_balancer_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
