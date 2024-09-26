use AzureNexus::server::NexusServer;

fn main() {
    let ip = String::from("localhost");

    let server = NexusServer::new(6121, &ip);
}
