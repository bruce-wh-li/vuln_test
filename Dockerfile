# Use a secure and supported Microsoft .NET SDK base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy and restore project dependencies (example Telerik web app)
COPY MyTelerikApp.csproj .
RUN dotnet restore

# Copy source and build
COPY . .
RUN dotnet publish -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copy published output
COPY --from=build /app .

# (Optional) Add Telerik licensing or private NuGet feed setup
# ENV TELERIK_LICENSE_KEY="your-license-key"

# Security step: run image scan (e.g., using trivy or Snyk)
# RUN trivy fs /app || true

EXPOSE 8080
ENTRYPOINT ["dotnet", "MyTelerikApp.dll"]
