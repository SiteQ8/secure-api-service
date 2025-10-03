# Secure API Service

[![CI](https://github.com/SiteQ8/secure-api-service/workflows/CI/badge.svg)](https://github.com/SiteQ8/secure-api-service/actions)
[![Security Scan](https://github.com/SiteQ8/secure-api-service/workflows/Security%20Scan/badge.svg)](https://github.com/SiteQ8/secure-api-service/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A secure, production-ready REST API service built with security-first principles and industry best practices.

## Features

- **Secure by Design**: Input validation, authentication, rate limiting, and comprehensive security controls
- **Production Ready**: Comprehensive logging, monitoring, error handling, and health checks
- **Developer Friendly**: Clear documentation, automated testing, and easy local development setup
- **Scalable Architecture**: Modular design supporting horizontal scaling and microservices patterns

## Quick Start

### Prerequisites

- Python 3.9+
- pip or pipenv
- Docker (optional)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/username/secure-api-service.git
cd secure-api-service
```

2. Create virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

5. Run the service:
```bash
python -m src.main.python.app
```

The API will be available at `http://localhost:8000`

### Docker Setup

```bash
docker build -t secure-api-service .
docker run -p 8000:8000 --env-file .env secure-api-service
```

## API Documentation

- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc
- **OpenAPI Spec**: http://localhost:8000/openapi.json

## Authentication

This API uses JWT-based authentication. Include the token in the Authorization header:

```bash
curl -H "Authorization: Bearer YOUR_JWT_TOKEN" \
     http://localhost:8000/api/v1/protected-endpoint
```

### Getting a Token

```bash
curl -X POST http://localhost:8000/api/v1/auth/login \
     -H "Content-Type: application/json" \
     -d '{"username": "your_username", "password": "your_password"}'
```

## Example Requests

### Health Check
```bash
curl http://localhost:8000/health
```

### Get User Profile
```bash
curl -H "Authorization: Bearer YOUR_JWT_TOKEN" \
     http://localhost:8000/api/v1/users/me
```

### Create Resource
```bash
curl -X POST http://localhost:8000/api/v1/resources \
     -H "Authorization: Bearer YOUR_JWT_TOKEN" \
     -H "Content-Type: application/json" \
     -d '{"name": "Sample Resource", "description": "A test resource"}'
```

## Development

### Running Tests
```bash
# Unit tests
python -m pytest tests/unit/

# Integration tests
python -m pytest tests/integration/

# Security tests
python -m pytest tests/security/

# All tests with coverage
python -m pytest --cov=src tests/
```

### Code Quality
```bash
# Linting
flake8 src/ tests/

# Type checking
mypy src/

# Security scanning
bandit -r src/
```

### Pre-commit Hooks
```bash
pip install pre-commit
pre-commit install
```

## Configuration

Configuration is managed through environment variables and YAML files:

- **Development**: `configs/dev.yaml`
- **Staging**: `configs/staging.yaml` 
- **Production**: `configs/prod.yaml`

Key environment variables:
- `DATABASE_URL`: Database connection string
- `SECRET_KEY`: JWT signing key
- `ENVIRONMENT`: Runtime environment (dev/staging/prod)
- `LOG_LEVEL`: Logging level (DEBUG/INFO/WARNING/ERROR)

## Security

### Security Features
- Input validation and sanitization
- JWT authentication with refresh tokens
- Rate limiting per IP and user
- CORS protection
- SQL injection prevention
- XSS protection
- Security headers (HSTS, CSP, etc.)
- Dependency vulnerability scanning
- Secret detection in commits

### Reporting Security Issues

Please see [SECURITY.md](SECURITY.md) for our security policy and how to report vulnerabilities.

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- **Documentation**: [docs/](docs/)
- **Issues**: [GitHub Issues](https://github.com/SiteQ8/secure-api-service/issues)
- **Discussions**: [GitHub Discussions](https://github.com/SiteQ8/secure-api-service/discussions)

## Roadmap

- [ ] GraphQL API support
- [ ] WebSocket real-time features
- [ ] Advanced monitoring and metrics
- [ ] Multi-tenant support
- [ ] API versioning strategy
