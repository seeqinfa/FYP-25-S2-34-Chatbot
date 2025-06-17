let chatbotInitialized = false;

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
    input.value = "";

    fetch("http://localhost:5005/webhooks/rest/webhook", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            sender: "user123", //can use session ID here
            message: msg
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.length === 0) {
            chatBox.innerHTML += `<div class="chat-message bot-message">...</div>`;
        } else {
            data.forEach(entry => {
                if (entry.text) {
                    chatBox.innerHTML += `<div class="chat-message bot-message">${entry.text}</div>`;
                }
            });
        }
        chatBox.scrollTop = chatBox.scrollHeight;
    })
    .catch(err => {
        chatBox.innerHTML += `<div class="chat-message bot-message">Sorry, I'm having trouble connecting to the server.</div>`;
        console.error("Rasa error:", err);
    });
}
