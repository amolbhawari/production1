FROM microsoft/dotnet-framework:4.7.2-sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet-framework:4.7.2-sdk
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "Production1.dll"]
