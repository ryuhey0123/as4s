//
//  InformationView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct InformationView: View {
    @Binding var output: String
    @Binding var input: String
    
    @State private var showingOutput: Bool = true
    @State private var showingInput: Bool = true
    
    var body: some View {
        VStack(spacing: -1.0) {
            HStack(spacing: -1.0) {
                if showingOutput {
                    InformationTextView(title: "Output", text: $output, idealWidth: 600)
                        .transition(.move(edge: .leading))
                }
                Divider()
                if showingInput {
                    InformationTextView(title: "Input", text: $input, idealWidth: 300)
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.interactiveSpring, value: showingOutput)
            .animation(.interactiveSpring, value: showingInput)
            
            Divider()
            
            InformationAccessory(showingOutput: $showingOutput, showingInput: $showingInput)
        }
    }
}

fileprivate struct InformationTextView: View {
    var title: String
    @Binding var text: String
    var idealWidth: CGFloat
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical) {
                Text("\n\n\n" + text)
                    .font(.callout)
                    .fontDesign(.monospaced)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.leading)
            }
            
            HStack {
                Text("\(title)")
                    .font(.headline)
                    .foregroundStyle(.tertiary)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }
            .padding(7)
        }
        .frame(idealWidth: idealWidth, maxWidth: .infinity)
    }
}

fileprivate struct InformationAccessory: View {
    @Binding var showingOutput: Bool
    @Binding var showingInput: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Toggle(isOn: $showingOutput, label: {
                Label("Show Output", systemImage: "square.leftthird.inset.filled")
                    .labelStyle(.iconOnly)
            })
            .toggleStyle(.button)
            .buttonStyle(.borderless)
            .onChange(of: showingOutput) {
                if !showingOutput && !showingInput {
                    showingInput = true
                    showingOutput = true
                }
            }
            
            Toggle(isOn: $showingInput, label: {
                Label("Show Input", systemImage: "square.rightthird.inset.filled")
                    .labelStyle(.iconOnly)
            })
            .toggleStyle(.button)
            .buttonStyle(.borderless)
            .onChange(of: showingInput) {
                if !showingOutput && !showingInput {
                    showingInput = true
                    showingOutput = true
                }
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}


#Preview {
    InformationView(output: .constant(SampleString.output), input: .constant(SampleString.input))
        .frame(width: 1000)
}

fileprivate enum SampleString {
    static let output: String = """

         OpenSees -- Open System For Earthquake Engineering Simulation
                 Pacific Earthquake Engineering Research Center
                        Version 3.5.1 64-Bit

      (c) Copyright 1999-2016 The Regents of the University of California
                              All Rights Reserved
  (Copyright and Disclaimer @ http://www.berkeley.edu/OpenSees/copyright.html)



 Node: 1
    Coordinates  : -500 -500 0
    Disps: 0 0 0 0 0 0
     unbalanced Load: 0 0 0 0 0 0
    ID : -1 -1 -1 -1 -1 -1


 Node: 2
    Coordinates  : 500 -500 0
    Disps: 0 0 0 -0.0287292 0.0394978 0.010584
     unbalanced Load: 0 0 0 0 0 0
    ID : -1 -1 -1 30 31 32


 Node: 3
    Coordinates  : -500 500 0
    Disps: 0 0 0 -0.013468 0.000628 0.0105829
     unbalanced Load: 0 0 0 0 0 0
    ID : -1 -1 -1 27 28 29


 Node: 4
    Coordinates  : 500 500 0
    Disps: 0 0 0 -0.0316324 0.00729853 0.00755214
     unbalanced Load: 0 0 0 0 0 0
    ID : -1 -1 -1 18 19 20


 Node: 5
    Coordinates  : -500 -500 1000
    Disps: 67.3158 23.9537 0.0530657 -0.0121538 0.0395667 0.057473
     unbalanced Load: 10000 0 0 0 0 0
    ID : 21 22 23 24 25 26


 Node: 6
    Coordinates  : 500 -500 1000
    Disps: 67.2744 98.5574 -0.00351351 -0.0313033 0.0277324 0.0604722
     unbalanced Load: 0 10000 0 0 0 0
    ID : 12 13 14 15 16 17


 Node: 7
    Coordinates  : -500 500 1000
    Disps: 5.81836 23.955 -0.00615972 -0.00922163 0.00733055 0.0604667
     unbalanced Load: 0 0 0 0 0 0
    ID : 6 7 8 9 10 11


 Node: 8
    Coordinates  : 500 500 1000
    Disps: 5.81905 98.5079 -0.0433925 -0.0301065 0.00373466 0.0589276
     unbalanced Load: 0 0 0 0 0 0
    ID : 0 1 2 3 4 5


ElasticBeam3d: 1
    Connected Nodes: 1 2
    CoordTransf: 1
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): 0 -105840 -317.52 -789956 2369.87 287292
    End 2 Forces (P Mz Vy My Vz T): 0 -211680 317.52 -1.57991e+06 -2369.87 -287292

ElasticBeam3d: 2
    Connected Nodes: 2 4
    CoordTransf: 2
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): 0 -287201 -544.084 -1.78182e+06 3621.7 321993
    End 2 Forces (P Mz Vy My Vz T): 0 -256883 544.084 -1.83988e+06 -3621.7 -321993

ElasticBeam3d: 3
    Connected Nodes: 3 4
    CoordTransf: 3
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): 0 -287180 -544.052 -171091 475.592 181644
    End 2 Forces (P Mz Vy My Vz T): 0 -256872 544.052 -304501 -475.592 -181644

ElasticBeam3d: 4
    Connected Nodes: 1 3
    CoordTransf: 4
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): 0 -105829 -317.487 -269359 808.078 -6280
    End 2 Forces (P Mz Vy My Vz T): 0 -211658 317.487 -538719 -808.078 6280

ElasticBeam3d: 5
    Connected Nodes: 5 6
    CoordTransf: 5
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): 4144.44 483932 937.873 -2.13392e+06 4031.16 191495
    End 2 Forces (P Mz Vy My Vz T): -4144.44 453941 -937.873 -1.89723e+06 -4031.16 -191495

ElasticBeam3d: 6
    Connected Nodes: 6 8
    CoordTransf: 6
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): 4949.65 44940.9 105.327 -1.85187e+06 3679.8 239977
    End 2 Forces (P Mz Vy My Vz T): -4949.65 60386.2 -105.327 -1.82793e+06 -3679.8 -239977

ElasticBeam3d: 7
    Connected Nodes: 7 8
    CoordTransf: 7
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): -69.0325 437978 891.346 -365681 659.445 208849
    End 2 Forces (P Mz Vy My Vz T): 69.0325 453369 -891.346 -293763 -659.445 -208849

ElasticBeam3d: 8
    Connected Nodes: 5 7
    CoordTransf: 8
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): -134.734 90797.5 151.658 -667030 1275.42 322361
    End 2 Forces (P Mz Vy My Vz T): 134.734 60860.3 -151.658 -608387 -1275.42 -322361

ElasticBeam3d: 9
    Connected Nodes: 1 5
    CoordTransf: 9
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): -5306.57 597072 1072.61 3.24762e+06 -5703.9 -574730
    End 2 Forces (P Mz Vy My Vz T): 5306.57 475534 -1072.61 2.45628e+06 5703.9 574730

ElasticBeam3d: 10
    Connected Nodes: 2 6
    CoordTransf: 10
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): 351.351 2.06911e+06 4112.47 1.9019e+06 -4039.12 -498882
    End 2 Forces (P Mz Vy My Vz T): -351.351 2.04337e+06 -4112.47 2.13721e+06 4039.12 498882

ElasticBeam3d: 11
    Connected Nodes: 4 8
    CoordTransf: 11
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): 4339.25 2.02152e+06 4058.31 -17491.4 -36.2947 -513755
    End 2 Forces (P Mz Vy My Vz T): -4339.25 2.03678e+06 -4058.31 53786.1 36.2947 513755

ElasticBeam3d: 12
    Connected Nodes: 3 7
    CoordTransf: 12
    mass density:  0, cMass: 0
    release about z:  0
    release about y:  0
    End 1 Forces (P Mz Vy My Vz T): 615.972 357075 756.613 177371 -220.69 -498838
    End 2 Forces (P Mz Vy My Vz T): -615.972 399538 -756.613 43319.7 220.69 498838
"""
    
    static let input = """
wipe
# Model
model basic -ndm 3 -ndf 6
# Nodes
node 1 -500.0 -500.0 0.0
node 2 500.0 -500.0 0.0
node 3 -500.0 500.0 0.0
node 4 500.0 500.0 0.0
node 5 -500.0 -500.0 1000.0
node 6 500.0 -500.0 1000.0
node 7 -500.0 500.0 1000.0
node 8 500.0 500.0 1000.0
# ElasticSection
section Elastic 1 10000.0 10000.0 500000.0 1000000.0 1000000.0 10000.0
# LinerTransformations
geomTransf Linear 1 0.0 0.0 -1.0
geomTransf Linear 2 0.0 0.0 -1.0
geomTransf Linear 3 0.0 0.0 -1.0
geomTransf Linear 4 0.0 0.0 -1.0
geomTransf Linear 5 0.0 0.0 -1.0
geomTransf Linear 6 0.0 0.0 -1.0
geomTransf Linear 7 0.0 0.0 -1.0
geomTransf Linear 8 0.0 0.0 -1.0
geomTransf Linear 9 1.0 0.0 0.0
geomTransf Linear 10 1.0 0.0 0.0
geomTransf Linear 11 1.0 0.0 0.0
geomTransf Linear 12 1.0 0.0 0.0
# Beams
element elasticBeamColumn 1 1 2 1 1
element elasticBeamColumn 2 2 4 1 2
element elasticBeamColumn 3 3 4 1 3
element elasticBeamColumn 4 1 3 1 4
element elasticBeamColumn 5 5 6 1 5
element elasticBeamColumn 6 6 8 1 6
element elasticBeamColumn 7 7 8 1 7
element elasticBeamColumn 8 5 7 1 8
element elasticBeamColumn 9 1 5 1 9
element elasticBeamColumn 10 2 6 1 10
element elasticBeamColumn 11 4 8 1 11
element elasticBeamColumn 12 3 7 1 12
# Trusses
# Fixes
fix 1 1 1 1 1 1 1
fix 2 1 1 1 0 0 0
fix 3 1 1 1 0 0 0
fix 4 1 1 1 0 0 0
# Masses
# TimeSeries
timeSeries Constant 1
# PlainPatterns
pattern Plain 1 1 {
    load 5 10000.0 0.0 0.0 0.0 0.0 0.0
    load 6 0.0 10000.0 0.0 0.0 0.0 0.0
}
# NodeRecorder
recorder Node -file tmp/node_disp.out -dof 1 2 3 4 5 6 disp
# System
system BandSPD
# Numberer
numberer RCM
# Constraints
constraints Plain
# Integrator
integrator LoadControl 1.0
# Algorithm
algorithm Linear
# Analysis
analysis Static
# Analyze
analyze 1
print -node
print -ele
"""
}
