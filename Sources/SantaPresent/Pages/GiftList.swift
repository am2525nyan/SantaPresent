import Foundation
import Ignite

struct GiftList: StaticPage {
    var title = "みんなのお願い"

    var body: some HTML {

        Section {
            // 装飾
            Text("🎄 ✨ 🎁")
                .class("decoration")
                .font(.title2)
                .horizontalAlignment(.center)
                .margin(.bottom, 10)

            // タイトル
            Text("みんなのお願い")
                .font(.custom("Yusei Magic", size: 40))
                .foregroundStyle(Color(hex: "#D42426"))
                .horizontalAlignment(.center)
                .margin(.bottom, 30)

            // ホームに戻るリンク
            Link("✉️ 手紙を書く", target: "/")
                .class("back-list-link")
                .horizontalAlignment(.center)
                .margin(.bottom, 20)

            // ギフトリストコンテナ
            Group {
                Text("読み込み中...")
                    .horizontalAlignment(.center)
            }
            .id("gift-list")
            .class("gift-list-container")

            // JavaScriptでギフトリストを読み込む
            Script(code: loadGiftsScript())
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

    // ギフトリストを取得して表示するJavaScript
    private func loadGiftsScript() -> String {
        """
        fetch('\(Config.giftsEndpoint)', {
            mode: 'cors',
            method: 'GET',
            headers: {
                'Accept': 'application/json'
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.json();
            })
            .then(gifts => {
                const container = document.getElementById('gift-list');

                if (gifts.length === 0) {
                    container.innerHTML = '<p class="no-gifts">まだお願いがありません</p>';
                    return;
                }

                // ギフトカードを作成
                container.innerHTML = gifts.map(gift => `
                    <div class="gift-card">
                        <div class="gift-name">🎅 ${gift.name}さん</div>
                        <div class="gift-present">🎁 ${gift.present}</div>
                    </div>
                `).join('');
            })
            .catch(error => {
                console.error('Error details:', error);
                const errorMsg = error.message.includes('CORS') || error.message.includes('NetworkError') || error.message === 'Failed to fetch'
                    ? 'お願いの読み込みに失敗しました（サーバー設定エラー）'
                    : `お願いの読み込みに失敗しました: ${error.message}`;
                document.getElementById('gift-list').innerHTML =
                    `<p class="error-message">${errorMsg}</p>`;
            });
        """
    }
}
