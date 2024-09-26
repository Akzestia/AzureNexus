use std::net::SocketAddr;
use tokio::io::AsyncReadExt;
use tokio::net::UdpSocket;
use tokio::sync::mpsc;
use tun2::AsyncDevice;

pub struct NexusServer {
    port: u16,
    ip: String,
    is_running: bool,
    tun_async_device: AsyncDevice,
}

impl NexusServer {
    pub fn new(port: u16, ip: String, tun_async_device: AsyncDevice) -> NexusServer {
        NexusServer {
            port,
            ip,
            is_running: false,
            tun_async_device,
        }
    }

    pub fn get_port(&self) -> u16 {
        self.port
    }

    pub fn get_ip(&self) -> &str {
        &self.ip
    }

    pub async fn listener_start(&mut self) -> Result<(), Box<dyn std::error::Error>> {
        self.is_running = true;
        let addr = format!("{}:{}", self.ip, self.port).parse::<SocketAddr>()?;
        let socket = UdpSocket::bind(&addr).await?;

        let (tx, mut rx) = mpsc::channel(100);

        let process_task = tokio::spawn(async move {
            while let Some(packet) = rx.recv().await {
                if let Err(e) = Self::process_packet(packet).await {
                    eprintln!("Error processing packet: {:?}", e);
                }
            }
        });

        let mut buf = vec![0u8; 1500];

        while self.is_running {
            match socket.recv_from(&mut buf).await {
                Ok((len, src)) => {
                    let packet = buf[..len].to_vec();
                    if let Err(e) = tx.send((packet, src)).await {
                        eprintln!("Error sending to processing task: {:?}", e);
                    }
                }
                Err(e) => eprintln!("Error receiving data: {:?}", e),
            }
        }

        drop(tx);
        process_task.await?;

        Ok(())
    }

    pub async fn listener_stop(&mut self) {
        if self.is_running {
            self.is_running = false;
        }
    }

    async fn process_packet(
        packet_info: (Vec<u8>, SocketAddr),
    ) -> Result<(), Box<dyn std::error::Error>> {
        let (packet, src) = packet_info;

        // TODO: Implement packet processing logic here
        println!("Processing packet of size {} from {}", packet.len(), src);

        Ok(())
    }

    async fn read_from_tun(&mut self) -> Result<(), Box<dyn std::error::Error>> {
        let mut buf = vec![0u8; 1500];
        loop {
            let n = self.tun_async_device.read(&mut buf).await?;
            let packet = &buf[..n];

            println!("Read {} bytes from TUN device", n);
        }
    }
}
