---
description: Setting up Tautulli for webhook-based push notifications
---

# Tautulli

## Preparation

* Read through the main [Notifications](./) page
* Copy your device-based or user-based webhook URL from LunaSea

## Setup the Webhook

Open Tautulli's web GUI, open the Settings and enter the "Notification Agents" page. Hit the "Add a new notification agent" button to add a new agent, and select "LunaSea". Please follow each tab below to setup the webhook:

{% tabs %}
{% tab title="Configuration" %}
#### **LunaSea Webhook URL**

Paste the full device-based or user-based URL that was copied from LunaSea.

#### LunaSea Profile

{% hint style="warning" %}
This step is only required if you are _**not**_ using the default LunaSea profile (`default`). LunaSea will assume the default profile when none is supplied.

Correctly setting up this field is critically important to get full deep-linking support.
{% endhint %}

Enter in the name of the profile which should be an **exact match** to the profile that this module instance was added to within LunaSea. Capitalization and punctuation _does_ matter.
{% endtab %}

{% tab title="Triggers" %}
Select which events should trigger a push notification. The following triggers are supported:

| Trigger                      | Supported? |
| ---------------------------- | :--------: |
| Playback Start               |  **Yes** ✅ |
| Playback Stop                |  **Yes** ✅ |
| Playback Pause               |  **Yes** ✅ |
| Playback Resume              |  **Yes** ✅ |
| Playback Error               |  **Yes** ✅ |
| Transcode Decision Change    |  **Yes** ✅ |
| Watched                      |  **Yes** ✅ |
| Buffer Warning               |  **Yes** ✅ |
| User Concurrent Streams      |  **Yes** ✅ |
| User New Device              |  **Yes** ✅ |
| Recently Added               |  **Yes** ✅ |
| Plex Server Down             |  **Yes** ✅ |
| Plex Server Back Up          |  **Yes** ✅ |
| Plex Remote Access Down      |  **Yes** ✅ |
| Plex Remote Access Back Up   |  **Yes** ✅ |
| Plex Update Available        |  **Yes** ✅ |
| Tautulli Update Available    |  **Yes** ✅ |
| Tautulli Database Corruption |  **Yes** ✅ |
{% endtab %}

{% tab title="Conditions" %}
You can _**optionally**_ add conditions that must be met for the webhook notifications to trigger.

You can set as many conditions as you like, and can combine different conditions for different triggers by adding separate webhooks to Tautulli.
{% endtab %}

{% tab title="Text" %}
A default message is set for all trigger types, but on this page you can alter the exact text that would appear in the message.

Please read the top of this tab in Tautulli about how to utilize the different modifiers.
{% endtab %}
{% endtabs %}

Once setup, close LunaSea and run the webhook test in Tautulli. You should receive a new notification letting you know that LunaSea is ready to receive Tautulli notifications!

## Attach Images to Notifications

Unlike other modules, in order to receive the actual images (posters, etc.) instead of a generic poster along with the notification, you will need to setup an image host within Tautulli. This step is _**optional**_ and not required, but recommended.

1. Go to Tautulli's web GUI
2. Open the Settings, enter "3rd Party APIs"
3. Select any of the available image providers
   * _**Note**: If selecting `Self-hosted on public domain`, ensure that the image path (_`/tautulli/image`) is publicly accessible from the internet
4. Follow the [3rd Party APIs Guide](https://github.com/Tautulli/Tautulli/wiki/3rd-Party-APIs-Guide) to acquire the required details for the chosen image provider
5. Enter and save the acquired API/Client ID information
