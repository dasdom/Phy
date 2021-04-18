//  Created by dasdom on 23.07.19.
//  Copyright © 2019 dasdom. All rights reserved.
//

import UIKit

class ImprintViewController: UIViewController {

  override func loadView() {
    
    let imprintView = ImprintView(frame: UIScreen.main.bounds)
    imprintView.textView.text = """
    Impressum
    Angaben gemäß § 5 TMG
    
    Dominik Hauser
    
    Kontakt:
    E-Mail: dominik.hauser@dasdom.de
    
    Haftungsausschluss:
    
    Haftung für Inhalte
    
    Die Inhalte unserer App wurden mit größter Sorgfalt erstellt. Für die Richtigkeit, Vollständigkeit und Aktualität der Inhalte können wir jedoch keine Gewähr übernehmen. Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte in dieser App nach den allgemeinen Gesetzen verantwortlich. Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen. Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt. Eine diesbezügliche Haftung ist jedoch erst ab dem Zeitpunkt der Kenntnis einer konkreten Rechtsverletzung möglich. Bei Bekanntwerden von entsprechenden Rechtsverletzungen werden wir diese Inhalte umgehend entfernen.
    
    Urheberrecht
    
    Die durch die App-Entwickler erstellten Inhalte und Werke in dieser App unterliegen dem deutschen Urheberrecht. Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. Downloads und Kopien dieser App sind nur für den privaten, nicht kommerziellen Gebrauch gestattet. Soweit die Inhalte in dieser App nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden Inhalte Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Inhalte umgehend entfernen.
    
    Datenschutz
    
    Es werden keinerlei Daten erhoben.
    
    Impressum vom Impressum Generator der Kanzlei Hasselbach, Rechtsanwälte für Arbeitsrecht und Familienrecht
    """

    view = imprintView
  }
  
  var contentView: ImprintView {
    return view as! ImprintView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismiss(sender:)))
    
    self.title = NSLocalizedString("Impressum", comment: "")
  }
  
  @objc func dismiss(sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
}
