import Foundation
import Ignite

struct Home: StaticPage {
    var title = "サンタさんへの手紙"
    var body: some HTML {
        
        Section {
            // 装飾
            Text("🎄 ✨ 🎁")
                .class("decoration")
                .font(.title2)
                .horizontalAlignment(.center)
                .margin(.bottom, 10)

            // タイトル
            Text("Dear Santa")
                .font(.custom("Yusei Magic",size: 40))
                .foregroundStyle(Color(hex: "#D42426"))
                .horizontalAlignment(.center)
                .margin(.bottom, 20)

            // ギフトリストへのリンク
            Link("🎁 みんなのお願いを見る", target: "/gift-list")
                .class("gift-list-link")
                .horizontalAlignment(.center)
                .margin(.bottom, 30)
            
            // フォーム
            Form(spacing: .large) {
                TextField("あなたのおなまえ")
                    .id("name")
                    .required()
                    .size(.small)
                
                TextField("おねがいしたいプレゼント")
                    .id("present")
                    .required()
                    .size(.small)
                
                Button("サンタさんに送る")
                    .type(.submit)
                    .class("send-btn")
            }
            .onEvent(.submit, [
                submitToBackend()
            ])
        }
        .class("letter-container")
        .padding(.vertical, 40)
        .padding(.horizontal, 80)
        .background("white")
        .frame(maxWidth: 1000)
        .cornerRadius(15)
        .shadow(.black.opacity(0.3), radius: 25, x: 0, y: 10)
        .border(.init(hex: "#165B33"), width: 10, edges: [.top, .bottom])
        
    }
    // バックエンドAPIへの送信アクション
    // Config.swiftで設定したAPIエンドポイントにデータを送信します
    private func submitToBackend() -> CustomAction {
        CustomAction("""
            event.preventDefault();

            console.log('Form submitted!');

            // フォームデータを取得
            const name = document.getElementById("name").value;
            const present = document.getElementById("present").value;

            console.log('Name:', name, 'Present:', present);

            // バックエンドAPIにPOSTリクエストを送信
            fetch('\(Config.giftsEndpoint)', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ name, present })
            })
            .then(response => {
                console.log('Response status:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('Success:', data);
                // 成功時の処理
                alert('サンタさんに手紙を送りました！届くといいね！');
                // フォームをクリア
                document.getElementById("name").value = '';
                document.getElementById("present").value = '';
            })
            .catch(error => {
                console.error('Error:', error);
                // エラー時の処理
                alert('送信に失敗しました。もう一度試してください。');
            });
        """)
    }
}
