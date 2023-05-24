//
//  AboutViewController.swift
//  MaxSales
//
//  Created by Fabio Miciano on 27/02/23.
//

import Foundation
import UIKit
import SwiftUI

extension AboutViewController.Layout {
    enum Sizing {
        static let imageHeight = 100
    }
}

final class AboutViewController: UIViewController {
    fileprivate enum Layout {}
    
    private lazy var logoImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logoMaxSales"))
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var aboutUsContentLabel: UILabel = {
        let label = UILabel()
        label.text = "Nós somos a Max Sales, um aplicativo que atua na área de descontos e benefícios, oferecendo praticidade e acessibilidade na palma da sua mão!\nVisamos atender variados públicos que não possuem acesso a uma qualidade excepcional de vida, promovendo acessibilidade à saúde, educação, cultura e segurança com mais facilidade através do nosso aplicativo de benefícios.\nNosso aplicativo visa abranger todas as necessidades do nosso cliente em um só lugar! Otimizando o seu tempo, oferecendo rapidez e economia sem sair de casa.\n \nDentre nosso aplicativo possuímos as seguintes categorias:\n Max Educacional, Max Saúde, Max Fitness, Max Seguros, Max Pet, Max Turismo\n \nAs categorias acima contam com descontos para cada especialidade para assim atender todas as carências de nossos usuários.\nNossa Matriz está localizada no centro de São Paulo, SP. na rua Libero Badaró, no bairro do Anhangabaú, local onde nossa equipe realiza toda a gestão e metodologia da nossa empresa."
        label.textAlignment = .center
        label.numberOfLines = 40
        label.textColor = UIColor(red: 0.30, green: 0.30, blue: 0.30, alpha: 1.00)
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.contentInset = .zero
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "QUEM SOMOS"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buildLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension AboutViewController: ViewConfiguration {
    func createHyerarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImage)
        contentView.addSubview(aboutUsContentLabel)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(view)
            $0.height.greaterThanOrEqualTo(view.frame.height)
        }
        
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
            $0.height.equalTo(Layout.Sizing.imageHeight)
        }
        
        aboutUsContentLabel.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(Spacing.base01)
        }
    }
}

struct AboutViewController_Preview: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview {
            let controller = AboutViewController()
            let navigation = UINavigationController(rootViewController: controller)
            return navigation
        }
    }
}
