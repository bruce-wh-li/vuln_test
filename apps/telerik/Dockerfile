# Dockerfile.linux
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app

# Create a minimal app folder (the app itself is a tiny ASP.NET host for detection)
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
RUN dotnet new web -n VulnWebApp
WORKDIR /src/VulnWebApp

# Copy a placeholder program file (the app)
RUN dotnet publish -c Release -o /app/out

# Stage: copy published app and add vulnerable Telerik artifacts (DLLs / packages)
FROM base AS final
WORKDIR /app
COPY --from=build /app/out ./

# ==== IMPORTANT: place the vulnerable Telerik DLL(s) here ====
# Option A (preferred if you have vendor DLLs): COPY the vendor DLLs into a known folder.
# For example, place 'Telerik.WinUI.dll' (or the relevant package .dll) into /app/lib/
# This demonstrates presence of vulnerable component for scanners.
# COPY vulnerable-binaries/Telerik.UI.for.WinUI.*.dll ./lib/

# If you don't have the DLL locally, you can simulate the package file:
RUN mkdir -p lib && echo "placeholder vulnerable telerik dll" > lib/Telerik.UI.for.WinUI-2.11.0.dll

EXPOSE 80
ENTRYPOINT ["dotnet", "VulnWebApp.dll"]
