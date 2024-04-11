FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /ikt206g24v-05

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /ikt206g24v-05
COPY --from=build-env /ikt206g24v-05/out .
ENTRYPOINT ["dotnet", "Example.dll"]