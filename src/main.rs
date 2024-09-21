use mini_redis::{client, Result};

#[tokio::main]
async fn main() -> Result<()> {
    let mut client = client::connect("127.0.0.1:6379").await?;

    client.set("uxux", "xuxu".into()).await?;

    let result = client.get("uxux").await?;

    println!("got value from the server; result={:?}", result);

    Ok(())
}
