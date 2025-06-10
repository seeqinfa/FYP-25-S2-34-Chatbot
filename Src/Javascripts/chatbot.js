let chatbotInitialized = false; // Make sure this is at the top

function toggleChatbot() {
    const body = document.getElementById("chatbot-body");
    const chatBox = document.getElementById("chat-messages");

    const isHidden = body.style.display === "none";
    body.style.display = isHidden ? "flex" : "none";

    if (isHidden && !chatbotInitialized) {
        chatBox.innerHTML += `<div class="chat-message bot-message">Hello! How can I assist you today?</div>`;
        chatbotInitialized = true;
    }

    if (isHidden) {
        setTimeout(() => {
            chatBox.scrollTop = chatBox.scrollHeight;
        }, 100);
    }
}

function sendChatMessage(event) {
    event.preventDefault();
    const input = document.getElementById("chat-input");
    const msg = input.value.trim();
    if (!msg) return;

    const chatBox = document.getElementById("chat-messages");
    chatBox.innerHTML += `<div class="chat-message user-message">${msg}</div>`;


    fetch(CONTROLLERS_URL + "/chatbotController.php", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "message=" + encodeURIComponent(msg)
    })
    .then(response => response.json())
    .then(data => {
        chatBox.innerHTML += `<div class="chat-message bot-message">${data.response}</div>`;
        input.value = "";
        chatBox.scrollTop = chatBox.scrollHeight;
    })
    .catch(err => {
        chatBox.innerHTML += `<div class="chat-message">Bot: Error occurred.</div>`;
        console.error(err);
    });
}

