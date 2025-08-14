@@ .. @@
    public function saveMessage(
        string $username,
        string $sender,  // 'user' | 'bot'
        string $text
    ): void {
-        $stmt = $this->db->prepare(
-            "INSERT INTO chat_messages (username, sender, message_text)
-             VALUES (:u, :s, :t)"
-        );
-        $stmt->execute([':u'=>$username, ':s'=>$sender, ':t'=>$text]);
+        try {
+            $stmt = $this->db->prepare(
+                "INSERT INTO chat_messages (username, sender, message_text)
+                 VALUES (:u, :s, :t)"
+            );
+            $stmt->execute([':u'=>$username, ':s'=>$sender, ':t'=>$text]);
+        } catch (PDOException $e) {
+            error_log("ChatbotEntity::saveMessage failed - " . $e->getMessage());
+            error_log("Parameters: username='{$username}', sender='{$sender}', text='{$text}'");
+            throw $e; // Re-throw to maintain existing error handling behavior
+        }
    }