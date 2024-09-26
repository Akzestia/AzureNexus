use tokio::runtime::Runtime;
use AzureNexus::server::NexusServer;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let ip = String::from("localhost");
    let mut config = tun2::Configuration::default();
    config
        .address((10, 0, 0, 9))
        .netmask((255, 255, 255, 0))
        .destination((10, 0, 0, 1))
        .up();

    #[cfg(target_os = "linux")]
    config.platform_config(|config| {
        config.ensure_root_privileges(true);
    });

    let rt = Runtime::new()?;

    let async_dev = rt.block_on(async {
        tun2::create_as_async(&config).expect("Failed to create async TUN device")
    });

    let mut server = NexusServer::new(6121, ip, async_dev);

    rt.block_on(async {
        let result = server.listener_start().await;
    });

    Ok(())
}
