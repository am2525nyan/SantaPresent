import Foundation
import Ignite

struct MainLayout: Layout {
    var body: some Document {
        Head {
            // Google Fonts
            MetaLink(href: "https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c:wght@700&family=Yusei+Magic&display=swap", rel: .stylesheet)

            // Custom CSS
            MetaLink(href: "/css/santa-letter.css", rel: .stylesheet)
        }

        Body {
            content
        }
    }
}
