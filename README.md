# Features

![Codespaces](https://img.shields.io/static/v1?style=for-the-badge&message=Codespaces&color=181717&logo=GitHub&logoColor=FFFFFF&label=)
![Devcontainers](https://img.shields.io/static/v1?style=for-the-badge&message=Devcontainers&color=2496ED&logo=Docker&logoColor=FFFFFF&label=)

💻 Works with [devcontainers](https://code.visualstudio.com/docs/devcontainers/containers)  \
☁️ Works with [GitHub Codespaces](https://github.com/features/codespaces)


## Usage

Just add a `.devcontainer/devcontainer.json` file with a `features` key.

📚 Make sure to inspect each feature for feature-specific options!

```json
{
	"image": "mcr.microsoft.com/devcontainers/universal",
	"features": {
		"ghcr.io/waruhachi/features/theos:latest": {}
	}
}
```

### Found a bug?

[🐞Open an bug report!🐞](https://github.com/waruhachi/features/issues/new?template=bug-report.yaml)
