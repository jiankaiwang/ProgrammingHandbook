# Firewall by IP Address in CSharp

<script type="text/javascript" src="../gitbook/app.js"></script>
<script type="text/javascript" src="../js/general.js"></script>

###取得內部網路 IP 位置
---

```C#
function string getInterNetwork() {
  string IP4Address = String.Empty;
  foreach (IPAddress IPA in Dns.GetHostAddresses(Dns.GetHostName()))
  {
      if (IPA.AddressFamily.ToString() == "InterNetwork")
      {
          IP4Address = IPA.ToString();
      }
  }
  return IP4Address;
}
```

###取得 http Request 的 IP 位置
---

```C#
private static string getCallerIP() {
    string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

    if (string.IsNullOrEmpty(ip))
    {
        ip = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
    }

    string[] stringSeparators = new string[] { ":", "," };
    string[] result = ip.Split(stringSeparators, StringSplitOptions.None);

    return (result[0]);
}
```

###驗證是否在同一個網域
---

引用外部類別來實作確認是否為相同 IP 網域，如下；

```C#
// check the ip address is the same
// usage : 
// ----------
// var ip1 = IPAddress.Parse("192.168.0.1");
// var ip2 = IPAddress.Parse("192.167.1.40");
// var mask = IPAddress.Parse("255.255.0.0");
// bool inSameNet = ip1.IsInSameSubnet(ip2, mask);
// ----------
public static class IPAddressExtensions
{
    public static IPAddress GetBroadcastAddress(this IPAddress address, IPAddress subnetMask)
    {
        byte[] ipAdressBytes = address.GetAddressBytes();
        byte[] subnetMaskBytes = subnetMask.GetAddressBytes();

        if (ipAdressBytes.Length != subnetMaskBytes.Length)
            throw new ArgumentException("IP or mask Length is error.");

        byte[] broadcastAddress = new byte[ipAdressBytes.Length];
        for (int i = 0; i < broadcastAddress.Length; i++)
        {
            broadcastAddress[i] = (byte)(ipAdressBytes[i] | (subnetMaskBytes[i] ^ 255));
        }
        return new IPAddress(broadcastAddress);
    }

    public static IPAddress GetNetworkAddress(this IPAddress address, IPAddress subnetMask)
    {
        byte[] ipAdressBytes = address.GetAddressBytes();
        byte[] subnetMaskBytes = subnetMask.GetAddressBytes();

        if (ipAdressBytes.Length != subnetMaskBytes.Length)
            throw new ArgumentException("IP or mask Length is error.");

        byte[] broadcastAddress = new byte[ipAdressBytes.Length];
        for (int i = 0; i < broadcastAddress.Length; i++)
        {
            broadcastAddress[i] = (byte)(ipAdressBytes[i] & (subnetMaskBytes[i]));
        }
        return new IPAddress(broadcastAddress);
    }

    public static bool IsInSameSubnet(this IPAddress address2, IPAddress address, IPAddress subnetMask)
    {
        IPAddress network1 = address.GetNetworkAddress(subnetMask);
        IPAddress network2 = address2.GetNetworkAddress(subnetMask);

        return network1.Equals(network2);
    }
}
```

假設於連入頁面時，便確認是否為相同網域，如以下範例：

```C#
private static bool sameNetwork(string network, string callerIP)
{
    // the network example is 10.0.2.15/255.255.255.0
    try
    {
        string[] stringSeparators = new string[] { "/" };
        string[] result = network.Split(stringSeparators, StringSplitOptions.None);
        var ip1 = IPAddress.Parse(result[0]);
        var ip2 = IPAddress.Parse(callerIP);
        var mask = IPAddress.Parse(result[1]);
        return ip1.IsInSameSubnet(ip2, mask);
    }
    catch
    {
        // catch all exception
        return false;
    }
}

protected void Page_Load(object sender, EventArgs e)
{
    // check firewall setting
    // allowedfirewall 如 10.0.2.15/255.255.255.0
    if (! sameNetwork(System.Web.Configuration.WebConfigurationManager.AppSettings["allowedfirewall"], getCallerIP()))
    {
        Response.Redirect("notAuthorized.aspx");
    }
}
```







