//
//  HostViewController.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

//"/Users/zihao.wang/Documents/BM{Six main concepts.md,STEEPLE.pdf,STEEPLE.md,Sample IA{BM SL IA Sample A comments.png,BM SL IA Sample C examiner comments.png,BM SL IA Sample A.pdf,BM SL IA sample B.pdf,BM SL IA Sample C.pdf,Leo IA.pdf,BM SL IA Sample B examiner comments.png},Main Idea in BM.md,MarketingQA.md,HBR%202002.docx,BM%20Oxford%20Quick%20Start%20Intro.pdf,Micheal Jackson.md,Balance Sheet.pdf,Biz PLan.docx,商管广告脚本.pdf,BMWebsite.pages,Checklist.docx,Biz PLan(1).docx,Videos{C0418.MP4,C0409.MP4,C0408.MP4,C0405.MP4,C0411.MP4,C0410.MP4,C0404.MP4,C0412.MP4,C0406.MP4,C0407.MP4,C0413.MP4,C0417.MP4,C0403.MP4,C0402.MP4,C0416.MP4,C0414.MP4,C0415.MP4,C0401.MP4},CAL.xlsx,商管广告脚本.md,Balance Sheet.md,Arthur-Wang-article summary.docx,storyboard.pdf,BMNotes{1.1.md,3.1{Internal sources of finance.md,The role of finance.md,External sources of finance.md},4.2 market planing.md,Unit 2 Keyterms.md,4.1 Role of Marketing.md,4.3 Sales forecasting.md,1.3.md,1.2.md,2.1.md},BMIA.docx,3.1-3.6 workbook questions.pdf,IA Data.xlsx,3.1- 3.6 Terms.xlsx,Formative_Question3.md,Bibliography_IA.md,BalanceSheetSalesForecast.xlsx,BM_Ads.mov,UI1.pages,Resources{BMhowtopresent articles.docx,Action Plan Website.docx,Biz Marketing project.doc,CUEGIS Explained (1).pptx,bibliograpy1.pdf},Arthur_BM_Article_Summary.docx,Images{1.2.2.1-An-overview-of-the-different-types-of-organisations-included-in-the-syllabus.5125e3f75acd915ee4a4.png,BM_SectionGraph.png},BM-HW-1.3.6.md,primary research-interviews.docx,BMWeb2.pages,Paul Hoang BM SEARCHABLE 2.pdf,Bibliography.md,primary research-blued.docx,BMWeb.pages,Pricing.md}"

class HostViewController: NSViewController {
    var dismissSelf: () -> Void = {}
    private var server: DroperServer = DroperServer("/Users/zihao.wang/Documents/DropFolder")
    lazy var hostMainView: HostView = {
//        data.setTreeBy(server)
//        let port = server.start()
        let view = HostView(data: data.getRootNode())
        view.port = 8888
//        print("port: \(port)\n")
        view.frame = self.view.bounds
        view.passord = self.passord
        view.delegate = self
        perror("err 35: ")
        return view
    }()
    lazy var data: OCFileTree = {
        return OCFileTree("/Users/zihao.wang/Documents/DropFolder", true)
    }()
    var passord: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        self.view.addSubview(hostMainView)
    }
    override func loadView() {
        guard let windowRect = NSApplication.shared.mainWindow?.frame else { return }
        view = NSView(frame: windowRect)
    }
    override func viewDidLayout() {
        super.viewDidLayout()
        hostMainView.frame = self.view.bounds
    }
}
extension HostViewController: HostViewDelegate {
    func back() {
        server.close()
        dismissSelf()
    }
    func checkProcess() {
        
    }
}
