FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/runtime:8.0
RUN mkdir -p /home/net_chat
RUN chmod 777 /home/net_chat
WORKDIR /App
COPY --from=build-env /App/out .
EXPOSE 9999
ENTRYPOINT ["dotnet", "Server.dll"]
