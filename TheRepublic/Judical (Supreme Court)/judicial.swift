//
//  judicial.swift
//  Tree of the USA
//
//  Created by x on 09/01/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import DeviceKit

class judicial: UIViewController {
    //Supreme court viewcontroller
    
    var tool = tools()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Judical")
        
        //Setup custom back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let yourBackImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func johnRoberts(_ sender: Any) {
        print("johnRoberts")
        
        let scotusVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusProfile") as! scotusProfile
        scotusVC.name = "John G. Roberts, Jr."
        scotusVC.pictureName = "scotus1"
        scotusVC.bio = "John G. Roberts, Jr., Chief Justice of the United States, was born in Buffalo, New York, January 27, 1955. He married Jane Marie Sullivan in 1996 and they have two children - Josephine and Jack. He received an A.B. from Harvard College in 1976 and a J.D. from Harvard Law School in 1979. He served as a law clerk for Judge Henry J. Friendly of the United States Court of Appeals for the Second Circuit from 1979–1980 and as a law clerk for then-Associate Justice William H. Rehnquist of the Supreme Court of the United States during the 1980 Term. He was Special Assistant to the Attorney General, U.S. Department of Justice from 1981–1982, Associate Counsel to President Ronald Reagan, White House Counsel’s Office from 1982–1986, and Principal Deputy Solicitor General, U.S. Department of Justice from 1989–1993. From 1986–1989 and 1993–2003, he practiced law in Washington, D.C. He was appointed to the United States Court of Appeals for the District of Columbia Circuit in 2003. President George W. Bush nominated him as Chief Justice of the United States, and he took his seat September 29, 2005."
        scotusVC.cspan = "https://www.c-span.org/person/?johngroberts"
        
        self.navigationController?.pushViewController(scotusVC, animated: true)
    }

    @IBAction func anthonyKennedy(_ sender: Any) {
        print("anthonyKennedy")
        let scotusVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusProfile") as! scotusProfile
        scotusVC.name = "Anthony M. Kennedy"
        scotusVC.pictureName = "scotus2"
        scotusVC.bio = "Anthony M. Kennedy, Associate Justice, was born in Sacramento, California, July 23, 1936. He married Mary Davis and has three children. He received his B.A. from Stanford University and the London School of Economics, and his LL.B. from Harvard Law School. He was in private practice in San Francisco, California from 1961–1963, as well as in Sacramento, California from 1963–1975. From 1965 to 1988, he was a Professor of Constitutional Law at the McGeorge School of Law, University of the Pacific. He has served in numerous positions during his career, including a member of the California Army National Guard in 1961, the board of the Federal Judicial Center from 1987–1988, and two committees of the Judicial Conference of the United States: the Advisory Panel on Financial Disclosure Reports and Judicial Activities, subsequently renamed the Advisory Committee on Codes of Conduct, from 1979–1987, and the Committee on Pacific Territories from 1979–1990, which he chaired from 1982–1990. He was appointed to the United States Court of Appeals for the Ninth Circuit in 1975. President Reagan nominated him as an Associate Justice of the Supreme Court, and he took his seat February 18, 1988. "
        scotusVC.cspan = "https://www.c-span.org/person/?anthonymkennedy"
        
        self.navigationController?.pushViewController(scotusVC, animated: true)
    }
    
    @IBAction func clarenceThomas(_ sender: Any) {
        print("clarenceThomas")
        
        let scotusVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusProfile") as! scotusProfile
        scotusVC.name = "Clarence Thomas"
        scotusVC.pictureName = "scotus3"
        scotusVC.bio = "Clarence Thomas, Associate Justice, was born in the Pinpoint community near Savannah, Georgia on June 23, 1948. He attended Conception Seminary from 1967-1968 and received an A.B., cum laude, from Holy Cross College in 1971 and a J.D. from Yale Law School in 1974. He was admitted to law practice in Missouri in 1974, and served as an Assistant Attorney General of Missouri, 1974-1977; an attorney with the Monsanto Company, 1977-1979; and Legislative Assistant to Senator John Danforth, 1979-1981. From 1981-1982 he served as Assistant Secretary for Civil Rights, U.S. Department of Education, and as Chairman of the U.S. Equal Employment Opportunity Commission, 1982-1990. From 1990-1991, he served as a Judge on the United States Court of Appeals for the District of Columbia Circuit. President Bush nominated him as an Associate Justice of the Supreme Court and he took his seat October 23, 1991. He married Virginia Lamp on May 30, 1987 and has one child, Jamal Adeen by a previous marriage. "
        scotusVC.cspan = "https://www.c-span.org/person/?clarencethomas"
        
        self.navigationController?.pushViewController(scotusVC, animated: true)
    }
    
    
    @IBAction func ruthBaderGinsburg(_ sender: Any) {
        print("ruthBaderGinsburg")
        
        let scotusVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusProfile") as! scotusProfile
        scotusVC.name = "Ruth Bader Ginsburg"
        scotusVC.pictureName = "scotus4"
        scotusVC.bio = "Ruth Bader Ginsburg, Associate Justice, was born in Brooklyn, New York, March 15, 1933. She married Martin D. Ginsburg in 1954, and has a daughter, Jane, and a son, James. She received her B.A. from Cornell University, attended Harvard Law School, and received her LL.B. from Columbia Law School. She served as a law clerk to the Honorable Edmund L. Palmieri, Judge of the United States District Court for the Southern District of New York, from 1959–1961. From 1961–1963, she was a research associate and then associate director of the Columbia Law School Project on International Procedure. She was a Professor of Law at Rutgers University School of Law from 1963–1972, and Columbia Law School from 1972–1980, and a fellow at the Center for Advanced Study in the Behavioral Sciences in Stanford, California from 1977–1978. In 1971, she was instrumental in launching the Women’s Rights Project of the American Civil Liberties Union, and served as the ACLU’s General Counsel from 1973–1980, and on the National Board of Directors from 1974–1980. She was appointed a Judge of the United States Court of Appeals for the District of Columbia Circuit in 1980. President Clinton nominated her as an Associate Justice of the Supreme Court, and she took her seat August 10, 1993. "
        scotusVC.cspan = "https://www.c-span.org/person/?ruthginsburg"
        
        self.navigationController?.pushViewController(scotusVC, animated: true)
    }
    
    
    @IBAction func stephenBreyer(_ sender: Any) {
        print("stephenBreyer")
        
        let scotusVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusProfile") as! scotusProfile
        scotusVC.name = "Stephen G. Breyer"
        scotusVC.pictureName = "scotus5"
        scotusVC.bio = "Stephen G. Breyer, Associate Justice, was born in San Francisco, California, August 15, 1938. He married Joanna Hare in 1967, and has three children - Chloe, Nell, and Michael. He received an A.B. from Stanford University, a B.A. from Magdalen College, Oxford, and an LL.B. from Harvard Law School. He served as a law clerk to Justice Arthur Goldberg of the Supreme Court of the United States during the 1964 Term, as a Special Assistant to the Assistant U.S. Attorney General for Antitrust, 1965–1967, as an Assistant Special Prosecutor of the Watergate Special Prosecution Force, 1973, as Special Counsel of the U.S. Senate Judiciary Committee, 1974–1975, and as Chief Counsel of the committee, 1979–1980. He was an Assistant Professor, Professor of Law, and Lecturer at Harvard Law School, 1967–1994, a Professor at the Harvard University Kennedy School of Government, 1977–1980, and a Visiting Professor at the College of Law, Sydney, Australia and at the University of Rome. From 1980–1990, he served as a Judge of the United States Court of Appeals for the First Circuit, and as its Chief Judge, 1990–1994. He also served as a member of the Judicial Conference of the United States, 1990–1994, and of the United States Sentencing Commission, 1985–1989. President Clinton nominated him as an Associate Justice of the Supreme Court, and he took his seat August 3, 1994. "
        scotusVC.cspan = "https://www.c-span.org/person/?stephengbreyer"
        
        self.navigationController?.pushViewController(scotusVC, animated: true)
    }
    
    
    @IBAction func samuelAlito(_ sender: Any) {
        print("samuelAlito")
        
        let scotusVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusProfile") as! scotusProfile
        scotusVC.name = "Samuel Anthony Alito, Jr."
        scotusVC.pictureName = "scotus6"
        scotusVC.bio = "Samuel Anthony Alito, Jr., Associate Justice, was born in Trenton, New Jersey, April 1, 1950. He married Martha-Ann Bomgardner in 1985, and has two children - Philip and Laura. He served as a law clerk for Leonard I. Garth of the United States Court of Appeals for the Third Circuit from 1976–1977. He was Assistant U.S. Attorney, District of New Jersey, 1977–1981, Assistant to the Solicitor General, U.S. Department of Justice, 1981–1985, Deputy Assistant Attorney General, U.S. Department of Justice, 1985–1987, and U.S. Attorney, District of New Jersey, 1987–1990. He was appointed to the United States Court of Appeals for the Third Circuit in 1990. President George W. Bush nominated him as an Associate Justice of the Supreme Court, and he took his seat January 31, 2006."
        scotusVC.cspan = "https://www.c-span.org/person/?samuelalito"
        
        self.navigationController?.pushViewController(scotusVC, animated: true)
    }
    
    
    @IBAction func soniaSotomayor(_ sender: Any) {
        print("soniaSotomayor")
        
        let scotusVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusProfile") as! scotusProfile
        scotusVC.name = "Sonia Sotomayor"
        scotusVC.pictureName = "scotus7"
        scotusVC.bio = "Sonia Sotomayor, Associate Justice, was born in Bronx, New York, on June 25, 1954. She earned a B.A. in 1976 from Princeton University, graduating summa cum laude and receiving the university's highest academic honor. In 1979, she earned a J.D. from Yale Law School where she served as an editor of the Yale Law Journal. She served as Assistant District Attorney in the New York County District Attorney's Office from 1979–1984. She then litigated international commercial matters in New York City at Pavia & Harcourt, where she served as an associate and then partner from 1984–1992. In 1991, President George H.W. Bush nominated her to the U.S. District Court, Southern District of New York, and she served in that role from 1992–1998. She served as a judge on the United States Court of Appeals for the Second Circuit from 1998–2009. President Barack Obama nominated her as an Associate Justice of the Supreme Court on May 26, 2009, and she assumed this role August 8, 2009."
        scotusVC.cspan = "https://www.c-span.org/person/?soniasotomayor"
        
        self.navigationController?.pushViewController(scotusVC, animated: true)
    }
    
    
    @IBAction func elenaKagan(_ sender: Any){
        print("elenaKagan")
        
        let scotusVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusProfile") as! scotusProfile
        scotusVC.name = "Elena Kagan"
        scotusVC.pictureName = "scotus8"
        scotusVC.bio = "Elena Kagan, Associate Justice, was born in New York, New York, on April 28, 1960. She received an A.B. from Princeton in 1981, an M. Phil. from Oxford in 1983, and a J.D. from Harvard Law School in 1986. She clerked for Judge Abner Mikva of the U.S. Court of Appeals for the D.C. Circuit from 1986-1987 and for Justice Thurgood Marshall of the U.S. Supreme Court during the 1987 Term. After briefly practicing law at a Washington, D.C. law firm, she became a law professor, first at the University of Chicago Law School and later at Harvard Law School. She also served for four years in the Clinton Administration, as Associate Counsel to the President and then as Deputy Assistant to the President for Domestic Policy. Between 2003 and 2009, she served as the Dean of Harvard Law School. In 2009, President Obama nominated her as the Solicitor General of the United States. A year later, the President nominated her as an Associate Justice of the Supreme Court on May 10, 2010. She took her seat on August 7, 2010."
        scotusVC.cspan = "https://www.c-span.org/person/?elenakagan"
        
        self.navigationController?.pushViewController(scotusVC, animated: true)
    }
    
    
    @IBAction func neilGorsuch(_ sender: Any) {
        print("neilGorsuch")
        
        let scotusVC = UIStoryboard(name: self.tool.sbName(), bundle: nil).instantiateViewController(withIdentifier: "scotusProfile") as! scotusProfile
        scotusVC.name = "Neil M. Gorsuch"
        scotusVC.pictureName = "scotus9"
        scotusVC.bio = "Neil M. Gorsuch, Associate Justice, was born in Denver, Colorado, August 29, 1967. He and his wife Louise have two daughters. He received a B.A. from Columbia University, a J.D. from Harvard Law School, and a D.Phil. from Oxford University. He served as a law clerk to Judge David B. Sentelle of the United States Court of Appeals for the District of Columbia Circuit, and as a law clerk to Justice Byron White and Justice Anthony M. Kennedy of the Supreme Court of the United States. From 1995-2005, he was in private practice, and from 2005-2006 he was Principal Deputy Associate Attorney General at the U.S. Department of Justice. He was appointed to the United States Court of Appeals for the Tenth Circuit in 2006. He served on the Standing Committee on Rules for Practice and Procedure of the U.S. Judicial Conference, and as chairman of the Advisory Committee on Rules of Appellate Procedure. He taught at the University of Colorado Law School. President Donald J. Trump nominated him as an Associate Justice of the Supreme Court, and he took his seat on April 10, 2017."
        scotusVC.cspan = "https://www.c-span.org/person/?neilgorsuch"
        
        self.navigationController?.pushViewController(scotusVC, animated: true)
    }
    
}
